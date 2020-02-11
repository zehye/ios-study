//
//  AppDelegate.swift
//  SignUp
//
//  Created by 안홍석 on 2020/01/30.
//  Copyright © 2020 안홍석. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "MainVC")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = homePage
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

