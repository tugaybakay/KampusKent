//
//  KKPaymentCardsTableViewCell.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit
import CreditCardView

class KKPaymentCardsTableViewCell: UITableViewCell {
    
    static let identifier = "KKPamenyCarsTableViewCellIdentifier"
    
    let cardIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "creditcard"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    let label: KKTitleLabel = {
        let label = KKTitleLabel(title: "1111 2222 3333 4444", fontSize: 30)
        label.textColor = .systemPink
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(cardIconView,label)
        accessoryType = .disclosureIndicator
//        translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func setUpConstraints() {
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            
            cardIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardIconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            cardIconView.widthAnchor.constraint(equalToConstant: 60),
            cardIconView.heightAnchor.constraint(equalToConstant: 60),
            
//            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            label.leftAnchor.constraint(equalTo: cardIconView.rightAnchor, constant: 15),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with cardNumber: String) {
        label.text = cardNumber
    }
}
