//
//  KKCard.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

struct KKCard: Codable {
    
    let user: String
    let cardNumber: String
    let expirationDate: String
    let CVC: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case cardNumber
        case expirationDate
        case CVC
    }
}
