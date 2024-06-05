//
//  KKTabBarVC.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//


import UIKit

class KKTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let homeVC = UINavigationController(rootViewController: KKHomeVC())
        let ticketVC = UINavigationController(rootViewController: KKTicketVC())
        
        
        homeVC.tabBarItem =  UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        ticketVC.tabBarItem = UITabBarItem(title: "Tickets", image: UIImage(systemName: "ticket"), tag: 2)
        
        self.setViewControllers([homeVC,ticketVC], animated: true)
        tabBar.tintColor = .systemYellow
    }
    

}
