//
//  KKLoginViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

final class KKLoginViewVM {
    
    func loginToFirebase(email: String, password: String, completion: @escaping (Result<KKUser,KKError>) -> Void) {
        KKFirebaseCRUDManager.shared.signInWithEmailAndPassword(email: email, password: password) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
