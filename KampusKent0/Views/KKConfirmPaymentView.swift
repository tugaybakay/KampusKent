//
//  KKConfirmPaymentView.swift
//  KampusKent0
//
//  Created by MacOS on 18.05.2024.
//

import UIKit
import CreditCardView

protocol KKConfirmPaymentViewDelegate: AnyObject {
    func confirmButtonDidTap()
}

final class KKConfirmPaymentView: UIView {
    
    weak var delegate: KKConfirmPaymentViewDelegate?
    
    let cardView: CreditCardView = {
        let c1:UIColor = .systemPink
        let c2:UIColor = .systemYellow
        let c3:UIColor = .red
        let cardview = CreditCardView(frame: CGRect(x: 0, y: 0, width: 390, height: 215), template: .Basic(c1,c2, c3))
        cardview.translatesAutoresizingMaskIntoConstraints = false
        return cardview
    }()
    
    let confirmButton: KKButton = {
        let button = KKButton(backgroundColor: .systemYellow, text: "Confirm")
        return button
    }()
    
    let costLabel: KKBodyLabel = {
        let label = KKBodyLabel(title: "Cost: 10TL", fontSize: 16)
        return label
    }()
    
    init(card: KKCard) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubViews(cardView,confirmButton,costLabel)
        setUpConstraints()
        configureCardView(card: card)
        confirmButton.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(cardView)
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 390),
            cardView.heightAnchor.constraint(equalToConstant: 215),
            
            costLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: padding),
            costLabel.leftAnchor.constraint(equalTo: confirmButton.leftAnchor, constant: 7),
            costLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            costLabel.heightAnchor.constraint(equalToConstant: 30),
            
            confirmButton.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 5),
            confirmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            confirmButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func confirmButtonDidTap() {
        delegate?.confirmButtonDidTap()
    }
    
    private func configureCardView(card: KKCard) {
        cardView.nameLabel.text = card.user
        cardView.expLabel.text = card.expirationDate
        cardView.numLabel.text = card.cardNumber
        cardView.brandLabel.text = "VISA"
        cardView.brandImageView.image = UIImage()
    }
    
    
}
