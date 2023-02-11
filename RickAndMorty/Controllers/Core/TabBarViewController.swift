//
//  TabBarViewController.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 28/01/23.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVcs()
    }
    
    private func configureVcs(){
        
        let charactersVC = CharacterViewController()
        let locationsVC = LocationsViewController()
        let episodesVC = EpisodesViewController()
        let settingsVC = SettingsViewController()
        
        let n1 = UINavigationController(rootViewController: charactersVC)
        let n2 = UINavigationController(rootViewController: locationsVC)
        let n3 = UINavigationController(rootViewController: episodesVC)
        let n4 = UINavigationController(rootViewController: settingsVC)
        
        n1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        n2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 2)
        n3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 3)
        n4.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 4)
        
        [n1,n2,n3,n4].forEach { navVC in
            navVC.navigationBar.prefersLargeTitles = true
        }
        
        self.setViewControllers(
            [n1,n2,n3,n4],
            animated: true)

    }
    
}
