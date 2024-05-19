//
//  KKTicketsView.swift
//  KampusKent0
//
//  Created by MacOS on 19.05.2024.
//

import UIKit

protocol KKTicetsViewDelegate: AnyObject {
    func didTapCell(qrImage: UIImage?)
}

final class KKTicketsView: UIView {
    
    let viewModel = KKTicketsViewVM()
    var delegate: KKTicetsViewDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(KKTicketsTableViewCell.self, forCellReuseIdentifier: KKTicketsTableViewCell.identifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        setUpConstraints()
        configureTableView()
        viewModel.subscribeClosure { [weak self] bool in
            if bool {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension KKTicketsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KKTicketsTableViewCell.identifier, for: indexPath) as! KKTicketsTableViewCell
        cell.configure(with: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
}

extension KKTicketsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapCell(qrImage: viewModel.generateQRCode(index: indexPath.row))
    }
}
