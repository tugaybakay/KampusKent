//
//  KKLoginView.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit

protocol KKLoginViewDelegate: AnyObject {
    func presentAlert(error: KKError)
    func goToHomePage(with user: KKUser)
    func goToDriverHomePage(with user: KKUser)
}

class KKLoginView: UIView {
    
    let viewModel: KKLoginViewVM = KKLoginViewVM()
    var delegate: KKLoginViewDelegate?
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comu")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let doneButton: KKButton = {
        let button = KKButton(backgroundColor: .systemYellow, text: "Login")
        return button
    }()
    
    let emailTextField: KKTextField = {
        let textField = KKTextField(placeholder: "Enter your email")
        textField.text = "test@driver.comu.edu.tr"
        return textField
    }()
    
    let passwordTextField: KKTextField = {
        let passwordTextField = KKTextField(placeholder: "Enter your password", textContentType: .password, returnKeyType: .done)
        passwordTextField.text = "test123"
        return passwordTextField
    }()
    
    var isEmailEntered: Bool { return !emailTextField.text!.isEmpty }
    var isPasswordEntered: Bool { return !passwordTextField.text!.isEmpty }

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(doneButton,emailTextField,passwordTextField,logoImageView)
        setUpConstraints()
        configureDoneButton()
        configureKeyboardDismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -150),
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            
//            passwordTextField.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -padding),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
//            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func configureDoneButton() {
        doneButton.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func doneButtonDidTap() {
        guard isPasswordEntered,isEmailEntered else {
            delegate?.presentAlert(error: .emptyUsernamePassword)
            return
        }
        let password = passwordTextField.text!
        let email = emailTextField.text!
        viewModel.loginToFirebase(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                print(user.email)
                if user.email.contains("driver") {
                    self?.delegate?.goToDriverHomePage(with: user)
                }else {
                    self?.delegate?.goToHomePage(with: user)
                }
            case .failure(let failure):
                self?.delegate?.presentAlert(error: failure)
            }
        }
    }
    
    private func configureKeyboardDismiss() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
}
