//
//  HomeTabBarController.swift
//  TouristNewsApp
//
//  Created by Martha Nashipae on 8/17/23.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       configureTabs()
    }
    
    private func configureTabs(){
        
        let vc1 = NewsFeedsViewController()
        let vc2 = TouristViewController()
        
        //Set Images
        vc1.tabBarItem.image  = UIImage(systemName: "house")
        vc2.tabBarItem.image  = UIImage(systemName: "person")
        
        //Set Tabs Name
        vc1.title = "News"
        vc2.title = "Tourist"
        
        //Set Navigation
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated:true)
    }
  

}
