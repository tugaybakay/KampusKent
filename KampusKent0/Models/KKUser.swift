//
//  KKUser.swift
//  KampusKent0
//
//  Created by MacOS on 3.06.2024.
//

import Foundation
import FirebaseFirestore

class KKUser {
    var email: String
    var name: String
    var surname: String
    var phoneNumber: String
    var validDate: Date
    
    init(email: String, name: String, surname: String, phoneNumber: String, validDate: Date) {
        self.email = email
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber
        self.validDate = validDate
    }
    
    func signOut() {
        
    }
    
    func signInWithEmailAndPassword() {
        
    }
}
