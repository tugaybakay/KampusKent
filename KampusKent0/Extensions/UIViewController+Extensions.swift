//
//  UIViewController+Extensions.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import UIKit

extension UIViewController {
    func presentKKAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = KKAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true)
        }
    }
}
