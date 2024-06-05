//
//  KKQRCodeVC.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import UIKit

class KKQRCodeVC: UIViewController {

    var qrView: KKQRCodeView!
    
    init(qrImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.qrView = KKQRCodeView(qrImage: qrImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavbar()
        view.addSubview(qrView)
        setUpContraints()
    }
    
    private func configureNavbar() {
        title = "QRCode"
        if let navBar = navigationController?.navigationBar {
            navBar.tintColor = .systemYellow
            navBar.prefersLargeTitles = true
        }
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            qrView.topAnchor.constraint(equalTo: view.topAnchor),
            qrView.leftAnchor.constraint(equalTo: view.leftAnchor),
            qrView.rightAnchor.constraint(equalTo: view.rightAnchor),
            qrView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
