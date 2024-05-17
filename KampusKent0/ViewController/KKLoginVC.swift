//
//  ViewController.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit


class KKLoginVC: UIViewController {
    
    let loginView: KKLoginView = KKLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHomeView()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Welcome"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor.systemYellow

            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "car.fill"), style: .done, target: self, action: #selector(driverButtonDidTap))
        
    }
    
    private func configureHomeView() {
        view.addSubview(loginView)
        loginView.delegate = self
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc private func driverButtonDidTap() {
        
    }

}

extension KKLoginVC: KKLoginViewDelegate {
    func presentAlert(error: KKError) {
        presentKKAlertOnMainThread(title: "Empty Email or Password", message: error.rawValue, buttonTitle: "Ok")
    }
    
    func goToHomePage(userEmail: String) {
        let destinatipnVC = KKTabBarVC()
        destinatipnVC.modalPresentationStyle = .fullScreen
        self.present(destinatipnVC, animated: true)
    }
}

