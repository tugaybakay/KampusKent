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
        let ticketVC = KKTicketVC()
        
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        ticketVC.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 2)
        
        self.setViewControllers([homeVC,ticketVC], animated: true)
        tabBar.tintColor = .systemYellow
    }
    

}
