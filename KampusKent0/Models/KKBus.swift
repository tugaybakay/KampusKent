//
//  KKBus.swift
//  KampusKent0
//
//  Created by MacOS on 3.06.2024.
//

import Foundation
import FirebaseFirestore

final class KKBus {
    var plateNumber: String!
    var busBrand: String!
    var model: String!
    var location: GeoPoint?
    
    init(plateNumber: String!, busBrand: String!, model: String!, location: GeoPoint? = nil) {
        self.plateNumber = plateNumber
        self.busBrand = busBrand
        self.model = model
        self.location = location
    }
    
    func getLocation() -> GeoPoint? {
        return location
    }
}
