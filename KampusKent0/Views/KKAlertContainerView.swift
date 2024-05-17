//
//  KKAlertContainerView.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit

protocol KKAlertContainerViewDelegate: AnyObject {
    func dismissVC()
}

class KKAlertContainerView: UIView {
    
    weak var delegate: KKAlertContainerViewDelegate?
    
    var titleLabel: KKTitleLabel!
    var bodyLabel: KKBodyLabel!
    var button: KKButton!

    init(title: String, message: String, buttonTitle: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        configureTitleLabel(title: title)
        configureBodyLabel(message: message)
        configureButton(buttonTitle: buttonTitle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitleLabel(title: String) {
        titleLabel = KKTitleLabel(title: title, textAlignment: .center, fontSize: 20)
        addSubview(titleLabel)
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureBodyLabel(message: String) {
        bodyLabel = KKBodyLabel(title: message, textAlignment: .center, fontSize: 17)
        bodyLabel.numberOfLines = 4
        addSubview(bodyLabel)
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bodyLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureButton(buttonTitle: String) {
        button = KKButton(backgroundColor: .systemPink, text: buttonTitle)
        addSubview(button)
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: padding),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        button.addTarget(self, action: #selector(dissmisVC), for: .touchUpInside)
    }
    
    @objc private func dissmisVC() {
        delegate?.dismissVC()
    }
}

