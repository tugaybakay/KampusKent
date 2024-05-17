//
//  KKHomeView.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit
import MapKit
import CoreLocation
import DropDown
import Firebase

protocol KKHomeViewDelegate: AnyObject {
    func doneButtonDidTap(startingStation: KKStation, destinationStation: KKStation)
    func alertShouldShow(error: KKError)
}

final class KKHomeView: UIView {
    
    let viewModel = KKHomeViewVM()
    weak var delegate: KKHomeViewDelegate?
    
    var startingAnnotation: MKPointAnnotation?
    var endingAnnotation: MKPointAnnotation?
    
    var startingStationIndex: Int {
        return viewModel.startingStationIndex
    }
    var destinationStationIndex: Int {
        return viewModel.destinationStationIndex
    }
    
    var annotations: [MKPointAnnotation] = []
    
    let mapView: MKMapView = {
        let mapView = MapKit.MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 30
        return mapView
    }()
    
    let titleLabel: KKTitleLabel = {
        let label = KKTitleLabel(title: "Where \nare you going?", textAlignment: .left, fontSize: 25)
        label.numberOfLines = 2
        return label
    }()
    
    let busImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bus-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mapPinImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "map-pin"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let busIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bus"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let startingLabel: KKBodyLabel = {
        let label = KKBodyLabel(title: "Select starting station",textAlignment: .center, fontSize: 32)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.layer.cornerRadius = 25
        return label
    }()
    
    let destinationLabel: KKBodyLabel = {
        let label = KKBodyLabel(title: "Select destination station",textAlignment: .center, fontSize: 32)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.layer.cornerRadius = 25
        return label
    }()
    
    let doneButton: KKButton = {
        let button = KKButton(backgroundColor: .systemPink, text: "Confirm")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(mapView,titleLabel,busImageView,startingLabel,destinationLabel,doneButton,mapPinImageView,busIconImageView)
        configureConstraints()
        viewModel.fetchStations()
        configureLabelTapGesture()
        doneButton.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            mapView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.3),
            
            titleLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 3),
            titleLabel.trailingAnchor.constraint(equalTo: busImageView.leadingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
            busImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            busImageView.heightAnchor.constraint(equalToConstant: 100),
            busImageView.widthAnchor.constraint(equalToConstant: 200),
            busImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            startingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding * 2),
            startingLabel.leadingAnchor.constraint(equalTo: mapPinImageView.trailingAnchor, constant: padding),
            startingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 3),
            startingLabel.heightAnchor.constraint(equalToConstant: 5 * padding),
            
            mapPinImageView.centerYAnchor.constraint(equalTo: startingLabel.centerYAnchor),
            mapPinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 3),
            mapPinImageView.heightAnchor.constraint(equalTo: startingLabel.heightAnchor, multiplier: 1),
            mapPinImageView.widthAnchor.constraint(equalToConstant: mapPinImageView.frame.width),
            
            destinationLabel.topAnchor.constraint(equalTo: startingLabel.bottomAnchor, constant: padding * 2),
            destinationLabel.leadingAnchor.constraint(equalTo: busIconImageView.trailingAnchor, constant: padding),
            destinationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 3),
            destinationLabel.heightAnchor.constraint(equalToConstant: 5 * padding),
            
            busIconImageView.centerYAnchor.constraint(equalTo: destinationLabel.centerYAnchor),
            busIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 3),
            busIconImageView.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor, multiplier: 1),
            busIconImageView.widthAnchor.constraint(equalToConstant: busIconImageView.frame.width),
            
            doneButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding * 3),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding * 3),
            doneButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding * 3),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func configureLabelTapGesture() {
        startingLabel.isUserInteractionEnabled = true
        destinationLabel.isUserInteractionEnabled = true
        destinationLabel.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(destinationLabelDidTap(_:))))
        startingLabel.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(startingLabelDidTap(_:))))
    }
    
    @objc func doneButtonDidTap() {
        if startingStationIndex == -1 || destinationStationIndex == -1 {
            delegate?.alertShouldShow(error: .emptyStation)
        }else if startingStationIndex == destinationStationIndex {
            delegate?.alertShouldShow(error: .stationsSame)
        }else{
            delegate?.doneButtonDidTap(startingStation: viewModel.stations[startingStationIndex], destinationStation: viewModel.stations[destinationStationIndex])
        }
    }
    
    @objc func startingLabelDidTap(_ sender: UITapGestureRecognizer) {
        if let sender = sender.view as? UILabel {
            showDropDownListForStarting(label: sender)
        }
    }
    
    @objc func destinationLabelDidTap(_ sender: UITapGestureRecognizer) {
        if let sender = sender.view as? UILabel {
            showDropDownListForDestination(label: sender)
        }
    }
    
    private func showDropDownListForStarting(label: UILabel) {
        let dropDown = DropDown()
        dropDown.anchorView = label.plainView
        dropDown.dataSource = viewModel.stations.map({
            return $0.name
        })
        dropDown.cellNib = UINib(nibName: "KKCustomDDCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? KKCustomDDCell else { return }
            cell.myImageView.image = UIImage(named: "map-pin")
        }
        dropDown.selectionAction = { [weak self] index, title in
            label.text = title
            guard let self = self else {return}
            let station = self.viewModel.stations[index]
            self.viewModel.startingStationIndex = index
            let annotation = MKPointAnnotation()
            if let oldAnnotation = self.viewModel.startingAnnotation { self.mapView.removeAnnotation(oldAnnotation) }
            self.viewModel.startingAnnotation = annotation
            self.setCenterOfMapView(geopoint: station.location, title: station.name, annotation: annotation)
        }
        dropDown.show()
    }
    
    private func showDropDownListForDestination(label: UILabel) {
        let dropDown = DropDown()
        dropDown.anchorView = label.plainView
        dropDown.dataSource = viewModel.stations.map({
            return $0.name
        })
        dropDown.cellNib = UINib(nibName: "KKCustomDDCell", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? KKCustomDDCell else { return }
            cell.myImageView.image = UIImage(named: "bus")
        }
        dropDown.selectionAction = { [weak self] index, title in
            label.text = title
            guard let self = self else {return}
            let station = self.viewModel.stations[index]
            self.viewModel.destinationStationIndex = index
            let annotation = MKPointAnnotation()
            if let oldAnnotation = self.viewModel.destinationAnnotation { self.mapView.removeAnnotation(oldAnnotation) }
            self.viewModel.destinationAnnotation = annotation
            self.setCenterOfMapView(geopoint: station.location, title: station.name, annotation: annotation)
        }
        dropDown.show()
    }
    
    private func setCenterOfMapView(geopoint: GeoPoint, title: String, annotation: MKPointAnnotation) {
        let coordinate = CLLocationCoordinate2D(latitude: geopoint.latitude, longitude: geopoint.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

