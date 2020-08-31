//
//  TabBarController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeBarItem = generateNavController(vc: HomeController(), title: "Home", image: UIImage(systemName: "house")!)
        let creationBarItem = generateNavController(vc: QuizCreationRootController(), title: "Create", image: UIImage(systemName: "plus.square")!)
        UINavigationBar.appearance().prefersLargeTitles = true
        UITabBar.appearance().backgroundColor = UIColor.clear
        UITabBar.appearance().tintColor = .black
        viewControllers = [homeBarItem, creationBarItem]
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        vc.navigationItem.titleView = setupTitleLabel(text: title)
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    fileprivate func setupTitleLabel(text: String) -> UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: LayoutHelper.pixelRelativeToScreen(toWidth: 200), height: LayoutHelper.pixelRelativeToScreen(toHeight: 50)))
        //let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: LayoutHelper.fontRelativeToScreen(toSize: 40))
        titleLabel.text = text
        titleLabel.backgroundColor = .clear
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        return titleLabel
    }
}
