//
//  HomeViewController.swift
//  WikipediaSearch
//
//  Created by Mohan on 21/07/18.
//  Copyright © 2018 Mohan. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController{
    var firstVC: UIViewController = SearchViewController()
    var secondVC : UIViewController = SavedViewController()
    var thirdVC : UIViewController = HistoryViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      
//        firstVC.title = "Wiki Search"
//        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        firstVC.tabBarItem.image = #imageLiteral(resourceName: "searchIconDark").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        firstVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "searchIconLight").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        secondVC.title = "Saved Searched"
//        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
//        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
//        thirdVC.title = "History"
//        
//        self.tabBarController?.viewControllers = [firstVC,secondVC,thirdVC]
//        var items  = self.tabBarController?.tabBar.items
//        items![0].image = #imageLiteral(resourceName: "searchIconDark").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        items![0].selectedImage = #imageLiteral(resourceName: "searchIconLight").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        items![1].image = #imageLiteral(resourceName: "savedIconDark").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        items![1].selectedImage = #imageLiteral(resourceName: "savedIconLight").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        items![2].image = #imageLiteral(resourceName: "historyIconDark").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        items![2].selectedImage = #imageLiteral(resourceName: "historyIconLight").withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
//        self.tabBarController?.viewControllers = [SearchViewController.self as! UIViewController,SavedViewController() as UIViewController, HistoryViewController.self as! UIViewController]
        tabBarController?.selectedViewController = tabBarController?.viewControllers![1]
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.selectedViewController = tabBarController?.viewControllers![2]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//    (self.tabBarController?.viewControllers![2] as! HistoryViewController).HistoryTable.reloadData()
    
    }
    
}

