//
//  DetailsVC.swift
//  InClass09
//
//  Created by Bollinger, Levi on 11/19/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DetailsVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var type: UILabel!
    var name1:String?
    var email1:String?
    var phone1:String?
    var type1:String?
    var ID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let rootRef = Database.database().reference()
        
        rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").observe(.value, with: {(snapshot) in
            
            if snapshot.value != nil{
                //clear contact list before regenerating it
                
                
                for c in snapshot.children{
                    
                    let cSnapshot = c as! DataSnapshot
                    
                    if cSnapshot.hasChild("name"){
                        self.name.text = (cSnapshot.childSnapshot(forPath: "name").value as! String)
                        print("Assigned name")
                    }
                    if cSnapshot.hasChild("email"){
                        self.email.text = (cSnapshot.childSnapshot(forPath: "email").value as! String)
                    }
                    if cSnapshot.hasChild("phone"){
                        self.phone.text = (cSnapshot.childSnapshot(forPath: "phone").value as! String)
                    }
                    if cSnapshot.hasChild("type"){
                        self.type.text = (cSnapshot.childSnapshot(forPath: "type").value as! String)
                    }
                    if cSnapshot.hasChild("ID"){
                        self.ID = (cSnapshot.childSnapshot(forPath: "ID").value as! String)
                    }
                    
                }
               
            }
        })
        
        name.text = name1
        email.text = email1
        phone.text = phone1
        type.text = type1
        
        print(ID!)
    }
    @IBAction func deleteContact(_ sender: Any) {
        let rootRef = Database.database().reference()
        
        rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").child(ID!).removeValue()
        navigationController?.popViewController(animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit"{
            let vc = segue.destination as! EditVC
            print("toEdit")
            
            vc.ID = ID
        }
    }

}
