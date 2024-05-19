//
//  KKPaymentVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

class KKPaymentVC: UIViewController {

    let paymentView = KKPaymentView()
    var ticket: KKTicket!
    
    init(ticket: KKTicket) {
        super.init(nibName: nil, bundle: nil)
        self.ticket = ticket
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(paymentView)
        setUpConstraints()
        paymentView.delegate = self
        view.backgroundColor = .systemBackground
        title = "Payment"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        if let tabBar = self.tabBarController { tabBar.tabBar.isHidden = false }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo: view.topAnchor),
            paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
extension KKPaymentVC: KKPaymentViewDelegate {
    func addCardDidTap() {
        let vc = KKAddCardVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func passConfirmPayment(card: KKCard) {
        let destinationVC = KKConfirmPaymentVC(card: card,ticket: ticket)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
