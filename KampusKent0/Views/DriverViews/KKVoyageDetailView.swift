//
//  KKVoyageDetailView.swift
//  KampusKent0
//
//  Created by MacOS on 5.06.2024.
//

import UIKit

class KKVoyageDetailView: UIView {

    var voyage: KKVoyage!
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bus.fill")
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var busBrandLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: voyage.bus.busBrand, textAlignment: .left, fontSize: 17)
        label.text = "Bus Brand: \(voyage.bus.busBrand!)"
        return label
    }()
    
    lazy var busModelLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: voyage.bus.model, textAlignment: .left, fontSize: 17)
        label.text = "Bus Model: \(voyage.bus.model!)"
        return label
    }()
    
    lazy var busPlateLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: voyage.bus.plateNumber, textAlignment: .left, fontSize: 17)
        label.text = "Bus Plate No: \(voyage.bus.plateNumber!)"
        return label
    }()
    
    lazy var voyageDateLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: "", textAlignment: .center, fontSize: 20)
        label.text = "Date: \(voyage.date.dateValue())"
        return label
    }()
    
    lazy var driverEmailLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: "", textAlignment: .center, fontSize: 20)
        label.text = "Driver: \(voyage.driverEmail!)"
        return label
    }()
    
    init(voyage: KKVoyage!) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.voyage = voyage
        addSubViews(imageView,busBrandLabel,busModelLabel,busPlateLabel,voyageDateLabel,driverEmailLabel)
        setUpconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpconstraints() {
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: padding),
            imageView.leftAnchor.constraint(equalTo: leftAnchor,constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            busBrandLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            busBrandLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            busBrandLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            busBrandLabel.heightAnchor.constraint(equalToConstant: 25),
            
            busModelLabel.topAnchor.constraint(equalTo: busBrandLabel.bottomAnchor, constant: 20),
            busModelLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            busModelLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            busModelLabel.heightAnchor.constraint(equalToConstant: 25),
            
            busPlateLabel.topAnchor.constraint(equalTo: busModelLabel.bottomAnchor, constant: 20),
            busPlateLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            busPlateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            busPlateLabel.heightAnchor.constraint(equalToConstant: 25),
            
            driverEmailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            driverEmailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            driverEmailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            driverEmailLabel.heightAnchor.constraint(equalToConstant: 22),
            
            voyageDateLabel.topAnchor.constraint(equalTo: driverEmailLabel.bottomAnchor, constant: 30),
            voyageDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            voyageDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            voyageDateLabel.heightAnchor.constraint(equalToConstant: 22)
            
        ])
    }

}
