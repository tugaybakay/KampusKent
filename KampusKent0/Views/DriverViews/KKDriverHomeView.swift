//
//  KKDriverHomeView.swift
//  KampusKent0
//
//  Created by MacOS on 5.06.2024.
//

import UIKit
import MapKit

final class KKDriverHomeView: UIView {
    
    var stations: [KKStation] = [] {
        didSet {
            var coordinates: [CLLocationCoordinate2D] = []
//            coordinates.append(CLLocationCoordinate2D(latitude: 40.11320, longitude: 26.42411))
            coordinates.append(contentsOf: prepareCoordinates())
            getDirections(for: coordinates)
            setAnnotations()
        }
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
        configureMapView()
        
        KKFirebaseCRUDManager.shared.fetchStationsFromTickets { result in
            switch result {
            case .success(let stations):
                self.stations = stations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMapView() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leftAnchor.constraint(equalTo: leftAnchor),
            mapView.rightAnchor.constraint(equalTo: rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func prepareCoordinates() -> [CLLocationCoordinate2D] {
        var geoPoints: [CLLocationCoordinate2D] = []
        for station in stations {
            
            let geoPoint = CLLocationCoordinate2D(latitude: station.location.latitude, longitude: station.location.longitude)
            geoPoints.append(geoPoint)
        }
        return geoPoints
    }
    
    func getDirections(for points: [CLLocationCoordinate2D]) {
            guard points.count > 1 else { return }

            var currentPointIndex = 0

            func getNextDirection() {
                if currentPointIndex < points.count - 1 {
                    let sourcePlacemark = MKPlacemark(coordinate: points[currentPointIndex])
                    let destinationPlacemark = MKPlacemark(coordinate: points[currentPointIndex + 1])
                    
                    let request = MKDirections.Request()
                    request.source = MKMapItem(placemark: sourcePlacemark)
                    request.destination = MKMapItem(placemark: destinationPlacemark)
                    request.transportType = .automobile
                    
                    let directions = MKDirections(request: request)
                    directions.calculate { response, error in
                        guard let response = response else {
                            if let error = error {
                                print("Error getting directions: \(error.localizedDescription)")
                            }
                            return
                        }
                        
                        let route = response.routes.first!
                        self.mapView.addOverlay(route.polyline)
                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                        
                        currentPointIndex += 1
                        getNextDirection()
                    }
                }
            }
            
            getNextDirection()
        }
    
    private func setAnnotations() {
        for station in stations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: station.location.latitude, longitude: station.location.longitude)
            annotation.title = station.name
            mapView.addAnnotation(annotation)
        }
    }
    
}

extension KKDriverHomeView: MKMapViewDelegate {
 
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemPink.withAlphaComponent(0.8)
            renderer.lineWidth = 3.5
            return renderer
        }

        return MKOverlayRenderer()
    }
}
