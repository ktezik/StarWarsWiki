//
//  TabBarViewController.swift
//  StarWarsWiki2
//
//  Created by Иван Гришин on 07.08.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
    }
    
    // MARK: - Private Methods
    
    private func setupTabBar() {
        tabBar.backgroundColor = .darkGray
        viewControllers = [
            createTab(MainScreenController(), title: "Home", imageSystemName: "house"),
            createTab(FavoriteScreenController(), title: "Favorite", imageSystemName: "star")
        ]
    }
    
    private func createTab(
        _ controller: UIViewController,
        title: String,
        imageSystemName: String
    ) -> UIViewController {
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: imageSystemName),
            selectedImage: UIImage(systemName: imageSystemName + ".fill")?.withRenderingMode(.alwaysOriginal)
        )
        tabBarItem.setTitleTextAttributes(
            [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)],
            for: .normal
        )
        
        controller.tabBarItem = tabBarItem
        controller.title = title
        return controller
    }
}
