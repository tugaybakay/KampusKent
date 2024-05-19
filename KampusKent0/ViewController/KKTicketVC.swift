//
//  KKTicketVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

class KKTicketVC: UIViewController {

    let ticketsView = KKTicketsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ticketsView)
        title = "Tickets"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureView()
    }
    
    private func configureView() {
        ticketsView.delegate = self
        
        NSLayoutConstraint.activate([
            ticketsView.topAnchor.constraint(equalTo: view.topAnchor),
            ticketsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ticketsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ticketsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension KKTicketVC: KKTicetsViewDelegate {
    func didTapCell(qrImage: UIImage?) {
        if let qrImage = qrImage {
            let destinationVC = KKQRCodeVC(qrImage: qrImage)
            navigationController?.pushViewController(destinationVC, animated: true)
        }else {
            self.presentKKAlertOnMainThread(title: "Bad Stuff Happend", message: "We oould not generate QR Code. Please try again 😢", buttonTitle: "Ok")
        }
    }
}
