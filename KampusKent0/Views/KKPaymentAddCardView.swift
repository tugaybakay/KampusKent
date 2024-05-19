//
//  KKPaymentTableHeaderView.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

final class KKPaymentAddCardView: UIView {
    
    let plusImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    let label: KKTitleLabel = {
        let label = KKTitleLabel(title: "Add Card", fontSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(plusImage,label)
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 30
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemYellow.cgColor
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            plusImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            plusImage.heightAnchor.constraint(equalToConstant: 50),
            plusImage.widthAnchor.constraint(equalToConstant: 50),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.leadingAnchor.constraint(equalTo: plusImage.trailingAnchor, constant: 20)
//            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
}
