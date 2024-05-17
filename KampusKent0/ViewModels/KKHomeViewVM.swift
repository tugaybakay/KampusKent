//
//  KKHomeViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation
import MapKit

final class KKHomeViewVM {
    
    var stations: [KKStation] = []
    
    var startingStationIndex = -1
    var destinationStationIndex = -1
    
    var startingAnnotation: MKPointAnnotation?
    var destinationAnnotation: MKPointAnnotation?
    
    func fetchStations() {
        KKFirebaseCRUDManager.shared.fetchStations { [weak self] result in
            switch result {
            case .success(let stationsFromFirebase):
                print("count \(stationsFromFirebase.count)")
                self?.stations.append(contentsOf: stationsFromFirebase)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
}

