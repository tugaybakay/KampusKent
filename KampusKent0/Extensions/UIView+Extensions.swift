//
//  UIView+Extensions.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
