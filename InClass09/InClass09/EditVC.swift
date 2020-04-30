//
//  EditVC.swift
//  InClass09
//
//  Created by Bollinger, Levi on 11/19/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditVC: UIViewController {

    var ID:String?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var phoneType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ID: " + ID!)
    }
    @IBAction func submit(_ sender: Any) {
        if nameField.text != "" && emailField.text != "" && phoneField.text != ""{
            let rootRef = Database.database().reference()
            let child = rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").child(ID!)
            
            child.updateChildValues(["name":nameField.text!, "email":emailField.text!, "phone":phoneField.text!, "type":phoneType.titleForSegment(at: phoneType.selectedSegmentIndex)!])
            
            navigationController?.popViewController(animated: true)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "One or more fields empty.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
}
