//
//  KKLoginViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

final class KKLoginViewVM {
    
    func loginToFirebase(email: String, password: String, completion: @escaping (KKError?) -> Void) {
        KKFirebaseCRUDManager.shared.signInWithEmailAndPassword(email: email, password: password) { error in
            if let error = error {
                completion(error)
                return
            }else{
                completion(nil)
            }
        }
        
    }
}
