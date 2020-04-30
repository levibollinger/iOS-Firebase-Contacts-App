//
//  ContactsViewController.swift
//  InClass09
//
//  Created by Shehab, Mohamed on 3/27/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ContactsViewController: UIViewController {
    let rootRef = Database.database().reference()
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [Contacts]()
    var tempCont = Contacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").observe(.value, with: {(snapshot) in
            
            if snapshot.value != nil{
                //clear contact list before regenerating it
                self.contacts.removeAll()
                
                for c in snapshot.children{
                    
                    let contact = Contacts()
                    
                    let cSnapshot = c as! DataSnapshot
                    
                    if cSnapshot.hasChild("name"){
                        contact.name = (cSnapshot.childSnapshot(forPath: "name").value as! String)
                    }
                    if cSnapshot.hasChild("email"){
                        contact.email = (cSnapshot.childSnapshot(forPath: "email").value as! String)
                    }
                    if cSnapshot.hasChild("phone"){
                        contact.phone = (cSnapshot.childSnapshot(forPath: "phone").value as! String)
                    }
                    if cSnapshot.hasChild("type"){
                        contact.phoneType = (cSnapshot.childSnapshot(forPath: "type").value as! String)
                    }
                    if cSnapshot.hasChild("ID"){
                        contact.ID = (cSnapshot.childSnapshot(forPath: "ID").value as! String)
                    }
                    self.contacts.append(contact)
                }
                print("Reload contacts")
                self.tableView.reloadData()
            }
        })
        
        print("Made it past reload")
        
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        //logout user in firebase first
        //then go to the login screen
        
        do{
            try Auth.auth().signOut()
            
            AppDelegate.showLogin()
        }
            catch{
            
            }
    }
}

extension ContactsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempCont = contacts[indexPath.row]
        print("First")
        performSegue(withIdentifier: "toDetails", sender: self)
    }
}

extension ContactsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = contacts.count
        
        print(result)
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! CellVC
        cell.name.text = contacts[indexPath.row].name!
        cell.email.text = contacts[indexPath.row].email!
        cell.phone.text = contacts[indexPath.row].phone! + " (" + contacts[indexPath.row].phoneType! + ")"
        cell.ID = contacts[indexPath.row].ID!
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails"{
            let vc = segue.destination as! DetailsVC
            print("Second")
        
            print(tempCont.name!)
        
            vc.ID = tempCont.ID
        }
    }
    
}
