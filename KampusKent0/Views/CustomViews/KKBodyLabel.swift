//
//  KKBodyLabel.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit

class KKBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, textAlignment: NSTextAlignment = .left, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.text = title
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: .body)
        configureLabel()
    }
    
    private func configureLabel() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
    }
}

