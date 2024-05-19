//
//  KKConfirmPaymentVC.swift
//  KampusKent0
//
//  Created by MacOS on 18.05.2024.
//

import UIKit

class KKConfirmPaymentVC: UIViewController {

    var confirmPaymentView: KKConfirmPaymentView!
    var card: KKCard!
    var ticket: KKTicket!
    
    init(card: KKCard, ticket: KKTicket){
        super.init(nibName: nil, bundle: nil)
        self.card = card
        self.ticket = ticket
        self.confirmPaymentView = KKConfirmPaymentView(card: card)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Payment"
        navigationController?.navigationBar.prefersLargeTitles = true
        confirmPaymentView.delegate = self
        view.addSubview(confirmPaymentView)
        configureView()
        // Do any additional setup after loading the view.
    }
    

    private func configureView() {
        NSLayoutConstraint.activate([
            confirmPaymentView.topAnchor.constraint(equalTo: view.topAnchor),
            confirmPaymentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            confirmPaymentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            confirmPaymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension KKConfirmPaymentVC: KKConfirmPaymentViewDelegate {
    func confirmButtonDidTap() {
        KKFirebaseCRUDManager.shared.addTicketToFirebase(with: ticket)
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
