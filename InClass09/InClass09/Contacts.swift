//
//  Contacts.swift
//  InClass09
//
//  Created by Bollinger, Levi on 11/18/19.
//  Copyright © 2019 UNCC. All rights reserved.
//

import Foundation

class Contacts{

var name:String?
var email:String?
var phone:String?
var phoneType:String?
var ID:String?

    init(name: String, email: String, phone:String, phoneType:String, ID:String){
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneType = phoneType
        self.ID = ID
    }
    
    init(){
        self.name = ""
        self.email = ""
        self.phone = ""
        self.phoneType = "HOME"
        self.ID = ""
    }

}
