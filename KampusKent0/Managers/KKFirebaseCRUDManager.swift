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
    private let userEmail = Auth.auth().currentUser?.email ?? ""
    
    private init() {}
    
    func fetchCardsFromFirebase(_ completion: @escaping (Result<[KKCard],Error>) -> Void) {
        firestore.collection("cards")
            .whereField("user", isEqualTo: userEmail)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                }else {
                    var cards: [KKCard] = []
                    if let snap = snapshot {
                        let docs = snap.documents
                        for doc in docs {
                            let data = doc.data()
                            let user = data["user"] as! String
                            let cvc = data["CVC"] as! String
                            let cardNumber = data["cardNumber"] as! String
                            let expirationDate = data["expirationDate"] as! String
                            let card = KKCard(user: user, cardNumber: cardNumber, expirationDate: expirationDate, CVC: cvc)
                            cards.append(card)
                        }
                        completion(.success(cards))
                    }
                    
                }
            }
    }
    
    func fetchTicketsFromFirebase(_ completion: @escaping (Result<[KKTicket],Error>) -> Void) {
        firestore.collection("tickets")
            .whereField("user", isEqualTo: userEmail)
            .order(by: "date", descending: true)
            .addSnapshotListener { snap, error in
                if let error = error {
                    completion(.failure(error))
                }else {
                    var tickets: [KKTicket] = []
                    let docs = snap!.documents
                    for doc in docs {
                        let data = doc.data()
                        let id = data["id"] as! String
                        let startingStationID = data["startingStationID"] as! Int
                        let destinationStationID = data["destinationStationID"] as! Int
                        let date = data["date"] as! Timestamp
                        let ticket = KKTicket(id: id,startingStationID: startingStationID, destinationStationID: destinationStationID, date: date)
                        tickets.append(ticket)
                    }
                    completion(.success(tickets))
                }
            }
    }
    
    func addTicketToFirebase(with ticket: KKTicket) {
        do{
            try firestore.collection("tickets").addDocument(from: ticket)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func addCardToFirebase(with card: KKCard) {
        do{
            try firestore.collection("cards").addDocument(from: card)
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
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
            if let _ = error {
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
                        stations.append(station)
                    }
                    completion(.success(stations))
                }
            }
        }
    }
    
    func fetchStationName(with id: Int, completion: @escaping (String?) -> Void) {
        firestore.collection("duraklar")
            .whereField("id", isEqualTo: id)
            .getDocuments { snapshot, error in
                if let _ = error {
                    completion(nil)
                }else {
                    if let snapshot = snapshot {
                        let docs = snapshot.documents
                        for doc in docs {
                            let data = doc.data()
                            let name = data["name"] as! String
                            print(name)
                            completion(name)
                            return
                        }
                    }
                }
            }
    }
    
    func deleteCard(card: KKCard) {
        firestore.collection("cards")
            .whereField("cardNumber", isEqualTo: card.cardNumber)
            .getDocuments { [weak self] snapshot, error in
                if let _ = error {
                    //TODO: Error handling
                }else {
                    if let snap = snapshot {
                        let docs = snap.documents
                        for doc in docs {
                            self?.firestore.collection("cards").document(doc.documentID).delete()
                        }
                        
                    }
                }
            }
    }
        
    func logOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

