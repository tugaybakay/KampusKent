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
    
    func fetchCardsFromFirebase(_ completion: @escaping (Result<[KKCard],Error>) -> Void) {
        let userEmail: String = Auth.auth().currentUser?.email ?? ""
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
    
    func fetchStationsFromTickets(_ completion: @escaping (Result<[KKStation],Error>) -> Void) {
        firestore.collection("tickets")
            .addSnapshotListener { snap, error in
                if let error = error {
                    completion(.failure(error))
                }else {
                    var stations_id: Set<Int> = []
                    let docs = snap!.documents
                    for doc in docs {
                        let data = doc.data()
                        let startingStationID = data["startingStationID"] as! Int
                        let destinationStationID = data["destinationStationID"] as! Int
                        stations_id.insert(startingStationID)
                        stations_id.insert(destinationStationID)
                    }
                    let id_array: [Int] = stations_id.sorted()
                    self.fetchStationWithID(with: id_array) { stations in
                        if let stations = stations {
                            completion(.success(stations))
                        }
                    }
                }
            }
    }
    
    private func fetchStationWithID(with id: [Int], _ completion: @escaping ([KKStation]?) -> Void) {
        firestore
            .collection("duraklar")
            .whereField("id", in: id)
            .getDocuments { snap, error in
                if error != nil {
                    completion(nil)
                }else {
                    let docs = snap!.documents
                    var stations: [KKStation] = []
                    for doc in docs {
                        let data = doc.data()
                        let location = data["location"] as! GeoPoint
                        let name = data["name"] as! String
                        let id = data["id"] as! Int
                        let station = KKStation(id: id, name: name, location: location)
                        stations.append(station)
                    }
                    completion(stations)
                }
            }
    }
    
    func fetchTicketsFromFirebase(_ completion: @escaping (Result<[KKTicket],Error>) -> Void) {
        let userEmail: String = Auth.auth().currentUser?.email ?? ""
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
    
    func signInWithEmailAndPassword(email: String, password: String, completion: @escaping (Result<KKUser,KKError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error != nil {
                completion(.failure(.incorrectUsernameOrPassword))
                return
            }else {
                if email.contains("driver") {
                    self.fetchUser(email: email, with: "drivers") { user in
                        if let user = user {
                            completion(.success(user))
                        }
                    }
                }else{
                    self.fetchUser(email: email, with: "users") { user in
                        if let user = user {
                            completion(.success(user))
                        }
                    }
                }
            }
        }
        
    }
    
    func fetchUser(email: String, with collection: String, completion: @escaping (KKUser?) -> Void)  {
        firestore.collection(collection).getDocuments { snap, error in
            if let snap = snap {
                let docs = snap.documents
                for doc in docs {
                    let data = doc.data()
                    let name = data["name"] as! String
                    let surname = data["surname"] as! String
                    let phoneNumber = data["phoneNumber"] as! String
                    let validDate = data["validDate"] as! Timestamp
                    let user = KKUser(email: email, name: name, surname: surname, phoneNumber: phoneNumber, validDate: validDate.dateValue())
                    completion(user)
                }
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
    
    func fetchVoyage(with id: String, _ completion: @escaping (KKVoyage?) -> Void) {
        firestore
            .collection("voyages")
            .whereField("id", isEqualTo: id)
            .getDocuments { snap, error in
                if error != nil {
                    completion(nil)
                }else {
                    let doc = snap!.documents.first!
                    let data = doc.data()
                    let busPlate = data["busPlate"] as! String
                    let date = data["date"] as! Timestamp
                    let driverEmail = data["driverEmail"] as! String
                    self.fetchBus(with: busPlate) { bus in
                        if let bus = bus {
                            let voyage = KKVoyage(driverEmail: driverEmail, date: date, id: id, bus: bus)
                            completion(voyage)
                        }
                    }
                }
            }
    }
    
    private func fetchBus(with busPlate: String, _ completion: @escaping (KKBus?) -> Void ) {
        firestore
            .collection("buses")
            .getDocuments { snap, error in
                if error != nil {
                    completion(nil)
                }else {
                    let doc = snap!.documents.first!
                    let data = doc.data()
                    let busBrand = data["busBrand"] as! String
                    let model = data["model"] as! String
                    let location = data["location"] as! GeoPoint
                    let bus = KKBus(plateNumber: busPlate, busBrand: busBrand, model: model, location: location)
                    completion(bus)
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

