//
//  KKTitleLabel.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

class KKTitleLabel: UILabel {

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
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configureLabel()
    }
    
    private func configureLabel() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
    }
}

