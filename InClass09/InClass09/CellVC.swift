//
//  CellVC.swift
//  InClass09
//
//  Created by Bollinger, Levi on 11/19/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CellVC: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel! //Phone number (Phone Type)
    var ID:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deleteCell(_ sender: Any) {
        let rootRef = Database.database().reference()
        
        rootRef.child("users").child((Auth.auth().currentUser?.uid)!).child("contacts").child(ID!).removeValue()
        
    }
    
}
