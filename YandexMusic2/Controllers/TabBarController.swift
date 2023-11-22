//
//  TabBarController.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 13.10.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().barTintColor = .clear
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.isTranslucent = true
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.layer.backgroundColor = UIColor.clear.cgColor
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurView, at: 1)
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: MainVC(), image: UIImage(systemName: "music.note")!.withBaselineOffset(fromBottom: 15.0)),
            createNavController(for: BooksPodcastsVC(), image: UIImage(systemName: "mic")!.withBaselineOffset(fromBottom: 15.0)),
            createNavController(for: MyCollectionVC(), image: UIImage(systemName: "heart.circle.fill")!.withBaselineOffset(fromBottom: 15.0))
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.tabBarItem.title = nil
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
