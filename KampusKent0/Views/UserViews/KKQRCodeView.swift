//
//  KKQRCodeView.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import UIKit

class KKQRCodeView: UIView {
    
    let qrCodeView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(qrImage: UIImage?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(qrCodeView)
        setUpConstraints()
        configureImageView(with: qrImage)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            qrCodeView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            qrCodeView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            qrCodeView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            qrCodeView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    func configureImageView(with image: UIImage?) {
        self.qrCodeView.image = image
    }
}
