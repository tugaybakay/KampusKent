//
//  KKTicketsViewVM.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import CoreImage
import UIKit


final class KKTicketsViewVM {
    
    private var stations: [KKStation] = [] {
        didSet {
            self.fetchTickets { bool in
                if bool {
                    self.closure?(true)
                }
            }
        }
    }
    var tickets: [KKTicket] = []
    var cellViewModels: [KKTicketsTableViewCellVM] = []
    
    var closure: ((Bool) -> Void)?
    
    init() {
        KKFirebaseCRUDManager.shared.fetchStations { [weak self] result in
            switch result {
            case .success(let stations):
                self?.stations = stations
            case .failure:
                break
            }
        }
    }
    
    func fetchTickets(_ completion: @escaping (Bool) -> Void) {
        KKFirebaseCRUDManager.shared.fetchTicketsFromFirebase { [weak self] result in
            switch result {
            case .success(let tickets):
                self?.tickets = tickets
                self?.createCellViewModels()
                completion(true)
            case .failure:
                completion(false)
            }
        }
    } 
    
    private func createCellViewModels() {
        cellViewModels.removeAll()
        var startingStationName: String!
        var destinationStationName: String!
        
        for ticket in tickets {
            for station in stations {
                if station.id == ticket.startingStationID {
                    startingStationName = station.name
                }else if station.id == ticket.destinationStationID{
                    destinationStationName = station.name
                }
            }
            let cellViewModel = KKTicketsTableViewCellVM(stratingStationName: startingStationName, destinationStationName: destinationStationName, dateString: ticket.date.dateValue().formatted())
            cellViewModels.append(cellViewModel)
        }
    }
    
    func generateQRCode(index: Int) -> UIImage? {
        let string = tickets[index].id
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 8.2, y: 8.2)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    func subscribeClosure(_ block: @escaping (Bool) -> Void) {
        self.closure = block
    }
}
