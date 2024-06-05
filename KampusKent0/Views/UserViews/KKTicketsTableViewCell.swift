//
//  KKTicketsTableViewCell.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import UIKit

class KKTicketsTableViewCell: UITableViewCell {
    
    static let identifier = "KKTicketsTableViewCell"
    
    let startingStationLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: "", fontSize: 21)
        return label
    }()
    
    let destinationStationLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: "", fontSize: 21)
        return label
    }()
    
    let dateLabel: KKBodyLabel = {
        let label = KKBodyLabel(title: "", fontSize: 12)
        return label
    }()
    
    let qrcodeIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "qrcode"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(startingStationLabel,destinationStationLabel,dateLabel,qrcodeIconImageView)
        setUpConstraints()
        accessoryType = .disclosureIndicator
//        contentView.translatesAutoresizingMaskIntoConstraints = false
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
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            qrcodeIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            qrcodeIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            qrcodeIconImageView.widthAnchor.constraint(equalToConstant: 120),
            qrcodeIconImageView.heightAnchor.constraint(equalToConstant: 120),
            
            startingStationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            startingStationLabel.leftAnchor.constraint(equalTo: qrcodeIconImageView.rightAnchor, constant: padding),
            startingStationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            startingStationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            destinationStationLabel.topAnchor.constraint(equalTo: startingStationLabel.bottomAnchor, constant: padding),
            destinationStationLabel.leftAnchor.constraint(equalTo: qrcodeIconImageView.rightAnchor, constant: padding),
            destinationStationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            destinationStationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: destinationStationLabel.bottomAnchor, constant: padding),
            dateLabel.leftAnchor.constraint(equalTo: qrcodeIconImageView.rightAnchor, constant: padding),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with cellViewModel: KKTicketsTableViewCellVM) {
        self.startingStationLabel.attributedText = prepareLabelAttributedText(iconName: "map-pin", text: cellViewModel.stratingStationName)
        self.destinationStationLabel.attributedText = prepareLabelAttributedText(iconName: "bus", text: cellViewModel.destinationStationName)
        self.dateLabel.text = cellViewModel.dateString
    }

    
    private func prepareLabelAttributedText(iconName: String, text: String) -> NSMutableAttributedString{
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: iconName)?.withTintColor(.label)
        let iconSize = CGRect(x: 0, y: -4, width: 23, height: 23)
        attachment.bounds = iconSize
        let attachmentString = NSAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(text)")
        let completeText = NSMutableAttributedString()
        completeText.append(attachmentString)
        completeText.append(textString)
        return completeText
    }
}
