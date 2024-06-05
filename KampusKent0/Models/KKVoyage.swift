//
//  KKVoyage.swift
//  KampusKent0
//
//  Created by MacOS on 5.06.2024.
//

import Foundation
import FirebaseFirestore

final class KKVoyage {
    var driverEmail: String!
    var date: Timestamp!
    var stations: [KKStation]?
    var id: String!
    var bus: KKBus!
    
    init(driverEmail: String!, date: Timestamp!, stations: [KKStation]? = nil, id: String!, bus: KKBus!) {
        self.driverEmail = driverEmail
        self.date = date
        self.stations = stations
        self.id = id
        self.bus = bus
    }
    
    func deleteVoyage() {
        
    }
}
