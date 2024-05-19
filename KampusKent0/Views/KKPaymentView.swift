//
//  KKPaymentView.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

protocol KKPaymentViewDelegate: AnyObject {
    func addCardDidTap()
    func passConfirmPayment(card: KKCard)
}

class KKPaymentView: UIView {
    
    let viewModel = KKPaymentViewVM()
    
    let addCardView = KKPaymentAddCardView()
    weak var delegate: KKPaymentViewDelegate?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(KKPaymentCardsTableViewCell.self, forCellReuseIdentifier: KKPaymentCardsTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(tableView,addCardView)
        tableView.dataSource = self
        tableView.delegate = self
        setUpConstraints()
        configureAddCard()
        viewModel.fetchCards { bool in
            if bool {
                self.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            addCardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            addCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            addCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            addCardView.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.topAnchor.constraint(equalTo: addCardView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureAddCard() {
        addCardView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addCardDidTap))
        addCardView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func addCardDidTap() {
        delegate?.addCardDidTap()
    }
    
}

extension KKPaymentView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KKPaymentCardsTableViewCell.identifier, for: indexPath) as! KKPaymentCardsTableViewCell
        cell.configure(with: viewModel.cards[indexPath.row].cardNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension KKPaymentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.passConfirmPayment(card: viewModel.cards[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, boolValue) in
            guard let self = self else { return }
            self.viewModel.deleteCard(card: self.viewModel.cards[indexPath.row])
        }
        item.image = UIImage(systemName: "trash")?.withTintColor(.white)
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        return swipeActions
    }
}
