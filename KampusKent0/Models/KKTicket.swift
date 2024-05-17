//
//  KKTicket.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation
import Firebase

struct KKTicket {
    let id = UUID().uuid
    let user: String
    let startingStationID: Int
    let destinationStationID: Int
    let date: Timestamp
}
