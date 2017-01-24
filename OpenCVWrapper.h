//
//  OpenCVWrapper.h
//  OpenCVNew
//
//  Created by Daniel Barkhorn on 1/5/17.
//  Copyright © 2017 Daniel Barkhorn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifdef __cplusplus
#include <vector>
#endif


@interface OpenCVWrapper : NSObject

+(UIImage *) getFromTraining:(int)index;
+(NSString *) getRowCol:(int)index;
+(UIImage *) addToTraining:(UIImage *)image;
+(NSString *) initializeTraining;
+(NSString *) getTrainVector;
+(NSString *) addLabelToTraining:(int)label;
+(int) predictFace:(UIImage *)face;

@end
