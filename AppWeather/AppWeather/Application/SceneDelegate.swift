//
//  SceneDelegate.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var dataSevenDay: DataWeather?
    var serverWeatherSevenDay = ServerWeatherSevenDay.shared
    
    // 785da7dc006dda8f97cd5e89504ccb4c key weather app;
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        searchVC.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let listWeatherVC = ListWeatherViewController()
        listWeatherVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 3)
        listWeatherVC.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let tabbarController = UITabBarController()
        tabbarController.delegate = self
        tabbarController.tabBar.barTintColor = UIColor.myBlueTabbar
        tabbarController.tabBar.tintColor = UIColor.white
        tabbarController.viewControllers = [homeVC, searchVC, listWeatherVC]
        
        
        
        
        serverWeatherSevenDay.requestSevenDay(completion: { dataWeather in
            
            print(dataWeather)
            self.dataSevenDay = dataWeather
            
            let imageDataDict:[String: DataWeather] = ["key": dataWeather]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: imageDataDict)
            
            
            
            print(self.dataSevenDay?.hourly.count)
            homeVC.dataSevenDay = dataWeather
            // khoi tao gia tri lan dau tien cho no
            
        })
        
        
        self.window = window
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(viewController)
        // check bam vao tabbar nào để làm sấng màn khác: , dung notification cũng có thể chuyển sang các màn, nên cũng không cần phải load vào hàm như này: 
        if let homView = viewController as? HomeViewController {
            homView.dataSevenDay = dataSevenDay
            
        } else if let searchView = viewController as? SearchViewController {
            print("s")
            
        } else if let lishView = viewController as? ListWeatherViewController {
            print("l")
            
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

