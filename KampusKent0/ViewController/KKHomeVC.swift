//
//  KKHomeVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit
import MapKit
import CoreLocation

final class KKHomeVC: UIViewController {
     
    let locationManager = CLLocationManager()
    let homeView = KKHomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHomeView()
        title = "Test"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    

    private func configureHomeView() {
        view.addSubview(homeView)
        homeView.delegate = self
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension KKHomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse || status == .authorizedAlways {
               // Konum izni alındı, konum güncellemelerini başlat
               locationManager.startUpdatingLocation()
           }
       }
       
       // Konum güncellendiğinde bu metot çağrılır
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           // Kullanıcının mevcut konumu locations dizisinde bulunur
           if let location = locations.last {
               let latitude = location.coordinate.latitude
               let longitude = location.coordinate.longitude
               print("Kullanıcı konumu - Latitude: \(latitude), Longitude: \(longitude)")
               locationManager.stopUpdatingLocation()
           }
       }
       // Konum h izmetleri hata verdiğinde bu metot çağrılır
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Konum hizmetleri hatası: \(error.localizedDescription)")
       }
}

extension KKHomeVC: KKHomeViewDelegate {
    func doneButtonDidTap(startingStation: KKStation, destinationStation: KKStation) {
        let destinationVC = KKPaymentVC()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func alertShouldShow(error: KKError) {
        self.presentKKAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
    }
}

