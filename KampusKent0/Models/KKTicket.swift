//
//  KKTicket.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation
import Firebase

struct KKTicket: Codable {
    var id: String = UUID().uuidString
    let user: String = Auth.auth().currentUser?.email ?? ""
    let startingStationID: Int
    let destinationStationID: Int
    let date: Timestamp
    
    enum CodingKeys: String,CodingKey {
        case id
        case user
        case startingStationID
        case destinationStationID
        case date
    }
}
