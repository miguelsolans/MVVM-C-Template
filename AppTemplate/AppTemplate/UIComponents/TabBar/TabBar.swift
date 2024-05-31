//
//  TabBar.swift
//  AppTemplate
//
//  Created by Miguel Solans on 30/05/2024.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        self.setupAppearance();
    }
    
    private func setupAppearance() {
        tabBar.tintColor = .systemBlue;
        tabBar.barTintColor = .systemBlue;
        tabBar.unselectedItemTintColor = .systemGray;
        // tabBar.backgroundColor = .white;
        tabBar.isTranslucent = true
    }
}
