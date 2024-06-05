//
//  KKDriverTabBarVC.swift
//  KampusKent0
//
//  Created by MacOS on 5.06.2024.
//

import UIKit

class KKDriverTabBarVC: UITabBarController {

    var driver: KKDriver!
    
    init(driver: KKDriver!) {
        super.init(nibName: nil, bundle: nil)
        self.driver = driver
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let homeVC = UINavigationController(rootViewController: KKDriverHomeVC(driver: driver))
        let detailVC = UINavigationController(rootViewController: KKVoyageDetailVC())
        
        
        homeVC.tabBarItem =  UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        detailVC.tabBarItem = UITabBarItem(title: "Voyage", image: UIImage(systemName: "info.circle"), tag: 2)
        
        self.setViewControllers([homeVC,detailVC], animated: true)
        tabBar.tintColor = .systemYellow
    }

}
