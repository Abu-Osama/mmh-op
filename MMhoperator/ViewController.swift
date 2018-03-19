//
//  ViewController.swift
//  MMhoperator
//
//  Created by Deepak mahadev on 22/02/18.
//  Copyright © 2018 Deepak mahadev. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    //let URL_USER_LOGIN = "http://www.makemyhall.com/m/operator/login_market_user.php"
    let URL_USER_LOGIN="http://www.makemyhall.com/m/operator/loginnew.php";
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var labelMessage: UILabel!
    //the connected views
    //don't copy instead connect the views using assistant editor
    
    @IBOutlet weak var textname: UITextField!
    
    // @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textpassword: UITextField!
    
    // @IBOutlet weak var textFieldPassword: UITextField!
    
    
    // @IBOutlet weak var textFieldPassword: UITextField!
    
    
    //    @IBOutlet weak var textFieldPassword: UITextField!
    //
    
    @IBAction func btnlogin(_ sender: Any) {
        
        self.showToast(message: "please wait.")
        
        
        
        
        let parameters: Parameters=[
            "email_id":textname.text!,
            "password":textpassword.text!
        ]
        
        
        // }
        //  @IBAction func buttonLogin(_ sender: UIButton) {
        //self.view.makeToast("This is a piece of toast")
        
        
        
        
        
        // making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                
                if let JSON = response.result.value{
                    //print("JSON: \(JSON)")
                    let jsonData = JSON as! NSDictionary
                    print(jsonData);
                    // return JSON
                }
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        // getting the user from response
                        //let user = jsonData.value(forKey: "name") as! NSDictionary
                        
                        // getting user values
                        // let userId = user.value(forKey: "0") as! Int
                        //                        let userName = user.value(forKey: "name") as! String
                        //                        let userEmail = user.value(forKey: "email") as! String
                        //                        let userPhone = user.value(forKey: "phone") as! String
                        //
                        //                      //  saving user values to defaults
                        //                        //self.defaultValues.set(userId, forKey: "userid")
                        //                        self.defaultValues.set(userName, forKey: "name")
                        //self.defaultValues.set(user, forKey: "email")
                        //self.defaultValues.set(userPhone, forKey: "phone")
                        
                        // switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)

                        self.dismiss(animated: false, completion: nil)
                    }
                    else{
                        
                        //error message in case of invalid credential
                       self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

