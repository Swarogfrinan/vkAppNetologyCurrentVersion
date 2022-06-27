//
//  AppDelegate.swift
//  Navigation
//
//  Created by Артем Свиридов on 04.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let loginFactory = LoginManager.makeLoginFactory()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController(loginFactory.getLoginInspector())
        window?.makeKeyAndVisible()
        return true
    }
}

