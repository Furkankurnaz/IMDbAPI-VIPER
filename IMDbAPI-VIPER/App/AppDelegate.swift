//
//  AppDelegate.swift
//  IMDbAPI-VIPER
//
//  Created by Furkan Kurnaz on 17.05.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        app.router.start()
        
        return true
    }

}

