//
//  SignUpViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        //sign up the new user using Firebase
        //when done successfully
        //go to the Contacts View Controller.
        
        if emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""{
            
            if passwordTextField.text == confirmPasswordTextField.text{
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {(authResult, error) in
                    if error == nil {
                        print("Success")
                        AppDelegate.showContacts()
                    } else {
                        print(error.debugDescription)
                    }
                    
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "One or more fields empty.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        AppDelegate.showLogin()
    }
    
}
