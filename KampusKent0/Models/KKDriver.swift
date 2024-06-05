//
//  KKDriver.swift
//  KampusKent0
//
//  Created by MacOS on 3.06.2024.
//

import Foundation

final class KKDriver: KKUser {
    
    var bus: KKBus?
    
    func setBus(bus: KKBus) {
        self.bus = bus
    }
}
