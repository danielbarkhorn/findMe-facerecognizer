//
//  StartViewController.swift
//  OpenCVNew
//
//  Created by Daniel Barkhorn on 1/16/17.
//  Copyright © 2017 Daniel Barkhorn. All rights reserved.
//

import UIKit

var trainingImages = [UIImage]()    //Holds all images to train facerecognizer with

class StartViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {

    //VARIABLES
    var mainImageIndex = 0
    
    //OUTLETS
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Camera and Photos function
    @IBAction func CameraPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func PhotosPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        mainImageView.image = newImage
        mainImageIndex = trainingImages.count-1
        indexLabel.text = "\(mainImageIndex)/\(trainingImages.count-1)"
        trainingImages.append(newImage)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func TrainPressed(_ sender: Any)
    {
        addAlToTraining()
        for i in 0 ..< trainingImages.count
        {
            OpenCVWrapper.add(toTraining: trainingImages[i])
            OpenCVWrapper.addLabel(toTraining: 1)
        }
        OpenCVWrapper.initializeTraining()

    }
    
    @IBAction func RightPressed(_ sender: Any)
    {
        if(mainImageIndex < trainingImages.count-1)
        {
            mainImageIndex+=1
            indexLabel.text = "\(mainImageIndex)/\(trainingImages.count-1)"
            mainImageView.image = trainingImages[mainImageIndex]
        }
    }
    @IBAction func LeftPressed(_ sender: Any)
    {
        if(mainImageIndex > 0)
        {
            mainImageIndex-=1
            indexLabel.text = "\(mainImageIndex)/\(trainingImages.count-1)"
            mainImageView.image = trainingImages[mainImageIndex]
        }
    }
    
    func addAlToTraining()
    {
        OpenCVWrapper.add(toTraining: #imageLiteral(resourceName: "Al_0"))
        OpenCVWrapper.addLabel(toTraining: 2)
        OpenCVWrapper.add(toTraining: #imageLiteral(resourceName: "Al_1"))
        OpenCVWrapper.addLabel(toTraining: 2)
        OpenCVWrapper.add(toTraining: #imageLiteral(resourceName: "Al_2"))
        OpenCVWrapper.addLabel(toTraining: 2)
        OpenCVWrapper.add(toTraining: #imageLiteral(resourceName: "Al_3"))
        OpenCVWrapper.addLabel(toTraining: 2)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
