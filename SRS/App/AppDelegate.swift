//
//  AppDelegate.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/2/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit
import SanjiPersistance

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        
        self.window = window
        self.applicationCoordinator = applicationCoordinator
        
        applicationCoordinator.start()
        
        return true
    }
    

}

