//
//  ViewController.swift
//  OpenCVNew
//
//  Created by Daniel Barkhorn on 1/5/17.
//  Copyright © 2017 Daniel Barkhorn. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let accessToken = AccessToken.current
//        {
//            
//        }
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends, .email])
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y/8
        //mainImage.image = #imageLiteral(resourceName: "Al_3")
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func display(_ sender: Any){
        mainImage.image = OpenCVWrapper.getFromTraining(Int32(textField.text!)!)
    }
    

    
    @IBAction func getFBPressed(_ sender: Any) {
        AccessToken.refreshCurrentToken()
        if AccessToken.current != nil
        {

//            let connection = GraphRequestConnection()
//            connection.add(MyProfileRequest()) { response, result in
//                switch result {
//                case .success(let response):
//                    print("Custom Graph Request Succeeded: \(response)")
//                    
//                case .failed(let error):
//                    print("Custom Graph Request Failed: \(error)")
//                }
//            }
//            connection.start()
            
//            var dict : NSDictionary!
//            
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//                    dict = result as! NSDictionary
//                    //println(self.dict)
//                    NSLog(((dict.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object("url") as! String)
//                }
//            })
            
            let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath:"/me", parameters: ["fields": "picture.type(large), id"])
            
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                
                if ((error) != nil)
                {
                    // Process error
                    print("Error: \(error)")
                }
                else
                {
                    print("Success \(result)")
                    self.returnUserProfileImage(accessToken: AccessToken.current!.appId as NSString)

                    self.nameLabel.text = "\(result)"
                }
            })
        }
    }
    
    func returnUserProfileImage(accessToken: NSString)
    {
        let userID = accessToken as NSString
        let facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(userID)/picture?type=large&&access_token=" + FBSDKAccessToken.current().tokenString)
        
//        if let data = NSData(contentsOf: facebookProfileUrl! as URL)
//        {
            mainImage.image = UIImage(data: NSData(contentsOf: facebookProfileUrl! as URL)! as Data)
//        }
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainImage: UIImageView!

}

