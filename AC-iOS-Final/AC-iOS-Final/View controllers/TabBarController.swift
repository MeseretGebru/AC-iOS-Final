//
//  TabBarController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        ///Feed
        let feedNavigation = UINavigationController(rootViewController: FeedViewController())
        ///UPload
        let uploadNavigation = UINavigationController(rootViewController: UploadViewController())
        
        feedNavigation.tabBarItem = UITabBarItem(title: "Feed", image: UIImage.init(named: "AppIcon"), tag: 0)
        uploadNavigation.tabBarItem = UITabBarItem(title: "Upload", image:#imageLiteral(resourceName: "upload"), tag: 1)
        let tabList = [feedNavigation, uploadNavigation]
        viewControllers = tabList
    }
    
}

