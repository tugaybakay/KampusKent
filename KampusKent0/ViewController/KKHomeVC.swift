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
     
//    let locationManager = CLLocationManager()
    let homeView = KKHomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHomeView()
        configureNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: true)
        title = "Home"
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
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
    
    private func configureNavbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "x.circle.fill"), style: .done, target: self, action: #selector(barButtonDidTap))
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = .systemYellow
            navigationBar.prefersLargeTitles = true
        }
        
    }
    
    @objc private func barButtonDidTap() {
        KKFirebaseCRUDManager.shared.logOut()
        let destinationVC = UINavigationController(rootViewController: KKLoginVC())
        destinationVC.modalPresentationStyle = .fullScreen
        navigationController?.dismiss(animated: true)
        self.present(destinationVC, animated: true)
    }
}

//extension KKHomeVC: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//           if status == .authorizedWhenInUse || status == .authorizedAlways {
//               // Konum izni alındı, konum güncellemelerini başlat
//               locationManager.startUpdatingLocation()
//           }
//       }
//       
//       // Konum güncellendiğinde bu metot çağrılır
//       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//           // Kullanıcının mevcut konumu locations dizisinde bulunur
//           if let location = locations.last {
//               let latitude = location.coordinate.latitude
//               let longitude = location.coordinate.longitude
//               print("Kullanıcı konumu - Latitude: \(latitude), Longitude: \(longitude)")
//               locationManager.stopUpdatingLocation()
//           }
//       }
//       // Konum h izmetleri hata verdiğinde bu metot çağrılır
//       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//           print("Konum hizmetleri hatası: \(error.localizedDescription)")
//       }
//}

@available(iOS 15, *)
extension KKHomeVC: KKHomeViewDelegate {
    func doneButtonDidTap(startingStation: KKStation, destinationStation: KKStation) {
        let ticket = KKTicket(startingStationID: startingStation.id, destinationStationID: destinationStation.id, date: .init(date: .now))
        let destinationVC = KKPaymentVC(ticket: ticket)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func alertShouldShow(error: KKError) {
        self.presentKKAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
    }
}

