//
//  KKVoyageDetailVC.swift
//  KampusKent0
//
//  Created by MacOS on 5.06.2024.
//

import UIKit

final class KKVoyageDetailVC: UIViewController {

    var detailView: KKVoyageDetailView! {
        didSet {
            view.addSubview(detailView)
            configureMapView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Voyage"
        configureNavbar()
        KKFirebaseCRUDManager.shared.fetchVoyage(with: "1") { voyage in
            guard let voyage = voyage else { fatalError("Voyage!") }
            self.detailView = KKVoyageDetailView(voyage: voyage)
        }
        view.backgroundColor = .systemBackground
    }
    
    private func configureMapView() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "x.circle.fill"), style: .done, target: self, action: #selector(barButtonDidTap))
        navigationController?.navigationBar.prefersLargeTitles = true
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = .systemYellow
            navigationBar.prefersLargeTitles = true
        }
        
    }
    
    @objc private func barButtonDidTap() {
        KKFirebaseCRUDManager.shared.logOut()
        let destinationVC = UINavigationController(rootViewController: KKLoginVC())
        destinationVC.modalPresentationStyle = .fullScreen
        navigationController?.dismiss(animated: true)
        self.present(destinationVC, animated: true)
    }

}
