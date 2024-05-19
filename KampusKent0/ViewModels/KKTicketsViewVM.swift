//
//  KKTicketsViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import Foundation

final class KKTicketsViewVM {
    
    var tickets: [KKTicket] = []
    
    func fetchTickets(_ completion: @escaping (Bool) -> Void) {
        KKFirebaseCRUDManager.shared.fetchTicketsFromFirebase { result in
            switch result {
            case .success(let tickets):
                self.tickets = tickets
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
