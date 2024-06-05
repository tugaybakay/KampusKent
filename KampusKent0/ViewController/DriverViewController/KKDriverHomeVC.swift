//
//  KKDriverHomeVC.swift
//  KampusKent0
//
//  Created by MacOS on 3.06.2024.
//

import UIKit

final class KKDriverHomeVC: UIViewController {

    var driver: KKDriver!
    let mapView = KKDriverHomeView()
    
    init(driver: KKDriver!) {
        super.init(nibName: nil, bundle: nil)
        self.driver = driver
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        configureMapView()
        
    
    }
    
    private func configureMapView() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}
