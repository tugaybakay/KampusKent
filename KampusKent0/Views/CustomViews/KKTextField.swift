//
//  KKTextField.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

class KKTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String, textContentType: UITextContentType = .emailAddress, returnKeyType: UIReturnKeyType = .done) {
        super.init(frame: .zero)
        if textContentType == .password {
            self.isSecureTextEntry = true
        }
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        self.textContentType = textContentType
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        tintColor = .label
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        font = .systemFont(ofSize: 20)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 17
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 20
        textAlignment = .center
        autocapitalizationType = .none

    }

}
