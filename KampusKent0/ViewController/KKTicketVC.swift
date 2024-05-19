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
        NSLayoutConstraint.activate([
            ticketsView.topAnchor.constraint(equalTo: view.topAnchor),
            ticketsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ticketsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ticketsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
