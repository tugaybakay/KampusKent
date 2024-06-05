//
//  KKAddCardVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import FormTextField
import UIKit


class KKAddCardVC: UIViewController {

    let height = CGFloat(60)
    let initialY = CGFloat(60)

    lazy var emailField: FormTextField = {
        let margin = CGFloat(20)
        let textField = FormTextField(frame: CGRect(x: margin, y: self.initialY, width: self.view.frame.width - (margin * 2.0), height: self.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputType = .email
        textField.placeholder = "Email"

        var validation = Validation()
        validation.minimumLength = 1
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator

        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        return textField
    }()

    lazy var cardNumberField: FormTextField = {
        let margin = CGFloat(20)
        var previousFrame = self.emailField.frame
        previousFrame.origin.y = self.emailField.frame.maxY + margin
        let textField = FormTextField(frame: previousFrame)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputType = .integer
        textField.formatter = CardNumberFormatter()
        textField.placeholder = "Card Number"

        var validation = Validation()
        validation.maximumLength = "1234 5678 1234 5678".count
        validation.minimumLength = "1234 5678 1234 5678".count
        let characterSet = NSMutableCharacterSet.decimalDigit()
        characterSet.addCharacters(in: " ")
        validation.characterSet = characterSet as CharacterSet
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator

        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        return textField
    }()

    lazy var cardExpirationDateField: FormTextField = {
        let margin = CGFloat(20)
        var previousFrame = self.cardNumberField.frame
        previousFrame.origin.y = self.cardNumberField.frame.maxY + margin
        previousFrame.size.width = previousFrame.size.width * 0.6
        let textField = FormTextField(frame: previousFrame)
        
        textField.formatter = CardExpirationDateFormatter()
        textField.placeholder = "Expiration Date (MM/YY)"

        var validation = Validation()
        validation.minimumLength = 1
        validation.maximumValue = 5
        let inputValidator = CardExpirationDateInputValidator(validation: validation)
        textField.inputValidator = inputValidator
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        textField.inputType = .integer
        return textField
    }()

    lazy var cvcField: FormTextField = {
        let margin = CGFloat(20)
        var previousFrame = self.cardNumberField.frame
        previousFrame.origin.x = self.cardExpirationDateField.frame.maxX + previousFrame.size.width * 0.05
        previousFrame.origin.y = self.cardNumberField.frame.maxY + margin
        previousFrame.size.width = previousFrame.size.width * 0.35
        let textField = FormTextField(frame: previousFrame)
        textField.inputType = .integer
        textField.placeholder = "CVC"

        var validation = Validation()
        validation.maximumLength = "CVC".count
        validation.minimumLength = "CVC".count
        validation.characterSet = NSCharacterSet.decimalDigits
        let inputValidator = InputValidator(validation: validation)
        textField.inputValidator = inputValidator

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 25
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemYellow.cgColor
        return textField
    }()


    lazy var addButton: KKButton = {
        let button = KKButton(backgroundColor: .systemPink, text: "Add")
        button.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        return button
    }()

    lazy var thiefImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "thief"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(named: "D4F3FF")
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Add Card"
        view.addSubview(emailField)
        view.addSubview(cardNumberField)
        view.addSubview(cardExpirationDateField)
        view.addSubview(cvcField)
        view.addSubview(addButton)
        view.addSubview(thiefImage)
        
        if let tabBar = self.tabBarController {
            tabBar.tabBar.isHidden = true
        }
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            emailField.heightAnchor.constraint(equalToConstant: padding),
            
            cardNumberField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            cardNumberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cardNumberField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardNumberField.heightAnchor.constraint(equalToConstant: padding),
            
            cardExpirationDateField.topAnchor.constraint(equalTo: cardNumberField.bottomAnchor, constant: 20),
            cardExpirationDateField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardExpirationDateField.widthAnchor.constraint(equalToConstant: 220),
            cardExpirationDateField.heightAnchor.constraint(equalToConstant: padding),

            cvcField.topAnchor.constraint(equalTo: cardExpirationDateField.bottomAnchor, constant: 20),
            cvcField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            cvcField.widthAnchor.constraint(equalToConstant: 100),
            cvcField.heightAnchor.constraint(equalToConstant: padding),
//
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addButton.topAnchor.constraint(equalTo: cvcField.bottomAnchor, constant: padding),
            addButton.heightAnchor.constraint(equalToConstant: padding),
            
            thiefImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            thiefImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thiefImage.widthAnchor.constraint(equalToConstant: 260),
            thiefImage.heightAnchor.constraint(equalToConstant: 260)
        ])
    }

    @objc func addAction() {
        let validEmail = emailField.validate()
        let validCardNumber = cardNumberField.validate()
        let validCardExpirationDate = cardExpirationDateField.validate()
        let validCVC = cvcField.validate()
        if validEmail && validCardNumber && validCardExpirationDate && validCVC {
            let email = emailField.text ?? ""
            let cardNumber = cardNumberField.text ?? ""
            let cardExpiration = cardExpirationDateField.text ?? ""
            let cvc = cvcField.text ?? ""
            let card = KKCard(user: email, cardNumber: cardNumber, expirationDate: cardExpiration, CVC: cvc)
            KKFirebaseCRUDManager.shared.addCardToFirebase(with: card)
            navigationController?.popViewController(animated: true)
//            let alertController = UIAlertController(title: "Valid!", message: "The payment details are valid", preferredStyle: .alert)
//            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
//            alertController.addAction(dismissAction)
//            present(alertController, animated: true, completion: nil)
        }else{
            self.presentKKAlertOnMainThread(title: "!!!", message: "Invalid Card informations!!!", buttonTitle: "Ok")
        }
    }
    



}
