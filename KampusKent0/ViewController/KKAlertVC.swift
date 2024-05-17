//
//  KKAlertVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit

class KKAlertVC: UIViewController {
    
    var containerView: KKAlertContainerView!
    
    var alertTitle: String!
    var message: String!
    var buttonTitle: String!

    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
    }
    
    private func configureContainerView() {
        containerView = KKAlertContainerView(title: alertTitle, message: message, buttonTitle: buttonTitle)
        containerView.delegate = self
        view.addSubview(containerView)
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 280),
            containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}

extension KKAlertVC: KKAlertContainerViewDelegate {
    func dismissVC() {
        self.dismiss(animated: true)
    }
}

