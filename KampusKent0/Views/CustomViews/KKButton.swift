//
//  KKButton.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

class KKButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, text: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(text, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 20
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

