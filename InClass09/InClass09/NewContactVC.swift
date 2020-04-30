//
//  NewContactVC.swift
//  InClass09
//
//  Created by Bollinger, Levi on 11/18/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewContactVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var phoneType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        print("dismissed")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func submit(_ sender: Any) {
        if name.text != "" && email.text != "" && phone.text != ""{
            let rootRef = Database.database().reference()
            
            //Assign directory to variable 'child'
            let child = rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").childByAutoId()
            
            //Get ID
            let randID = child.key
            
            //Assign values
            child.setValue(["name":name.text!, "email":email.text!, "phone":phone.text!, "type":phoneType.titleForSegment(at: phoneType.selectedSegmentIndex), "ID":randID])
            
            AppDelegate.showContacts()
        }
    }
}
