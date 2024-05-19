//
//  KKPaymentViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

final class KKPaymentViewVM {
    var cards: [KKCard] = []
    
    func deleteCard(card: KKCard) {
        KKFirebaseCRUDManager.shared.deleteCard(card: card)
    }
    
    func fetchCards(_ completion: @escaping (Bool) -> Void) {
        KKFirebaseCRUDManager.shared.fetchCardsFromFirebase { result in
            switch result {
            case .success(let cards):
                self.cards = cards
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
