//
//  KKFirebaseCRUDManager.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class KKFirebaseCRUDManager {
    static let shared = KKFirebaseCRUDManager()
    private let firestore = Firestore.firestore()
    
    private init() {}
    
    func signInWithEmailAndPassword(email: String, password: String, completion: @escaping (KKError?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                completion(.incorrectUsernameOrPassword)
                return
            }else {
                completion(nil)
            }
        }
        
    }
    
    func fetchStations(completion: @escaping (Result<[KKStation],KKError>) -> Void) {
        let collection = firestore.collection("duraklar")
        collection.order(by: "id").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.errorFetchingData))
            }else {
                if let snapshot = snapshot {
                    let docs = snapshot.documents
                    var stations: [KKStation] = []
                    for doc in docs {
                        let data = doc.data()
                        let id = data["id"] as! Int
                        let name = data["name"] as! String
                        let location = data["location"] as! GeoPoint
                        let station = KKStation(id: id, name: name, location: location)
                        print(name)
                        stations.append(station)
                    }
                    completion(.success(stations))
                }
            }
        }
    }
}

