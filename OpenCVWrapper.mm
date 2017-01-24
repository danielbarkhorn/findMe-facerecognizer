//
//  OpenCVWrapper.mm
//  OpenCVNew
//
//  Created by Daniel Barkhorn on 1/5/17.
//  Copyright © 2017 Daniel Barkhorn. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/core/core_c.h>
#import <opencv2/highgui/ios.h>
#include "vector"
#include <iostream>


@implementation OpenCVWrapper

std::vector<cv::Mat> trainingMat;
std::vector<int> trainingLabels;
cv::Ptr<cv::FaceRecognizer> model = cv::createFisherFaceRecognizer();
int trained = 0;

+(UIImage *) getFromTraining:(int)index
{
    return MatToUIImage(trainingMat[index]);
}

+(NSString *) getRowCol:(int)index
{
    std::string temp = "Row: " + std::to_string(trainingMat[index].rows) + ", Col: " + std::to_string(trainingMat[index].cols);
    return @(temp.c_str());
}

+(UIImage *) addToTraining:(UIImage *)image
{
    cv::Mat temp, gray, dst;
    UIImageToMat(image, temp);
    cv::cvtColor(temp, gray, CV_BGR2GRAY);
    cv::Size size(200,200);
    cv::resize(gray, dst, size);
//    cv::normalize(gray, dst, 0, 255, cv::NORM_MINMAX, CV_8UC1);
    trainingMat.push_back(dst);
    return image;
}

+(NSString *) addLabelToTraining:(int)label
{
    trainingLabels.push_back(label);
    return [NSString stringWithFormat:@""];
}

+(NSString *) getTrainVector
{
    std::string vect = "MatSize: " + std::to_string(trainingMat.size()) + " Labels: ";
    for(int i = 0; i < trainingLabels.size(); i++)
    {
        vect.append(std::to_string(trainingLabels[i]));
        vect.append(", ");
    }
    return @(vect.c_str());
}

+(NSString *) initializeTraining
{
    trained = 1;
    model->train(trainingMat, trainingLabels);
    return [NSString stringWithFormat:@"Trained set to True(?)"];
}

+(int) predictFace:(UIImage *)face
{
    if(trained == 0)    return 0;
    cv::Mat temp, gray;
    UIImageToMat(face, temp);
    cv::cvtColor(temp, gray, CV_BGR2GRAY);
    cv::Mat dst;
    cv::normalize(gray, dst, 0, 255, cv::NORM_MINMAX, CV_8UC1);
    int predictedLabel;
    double predictedConfidence;
    model->predict(gray, predictedLabel, predictedConfidence);
    return predictedLabel;
}



@end
