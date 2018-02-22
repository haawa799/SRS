//
//  ApplicationCoordinator.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/21/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import Foundation
import UIKit

enum ApplicationState {
    case onboarding
    case tabs
    case empty
}

class ApplicationCoordinator: NSObject, Coordinator {
    
    private let tabsRootViewController = UITabBarController()
    private let onboardingRootViewController = UINavigationController()
    private let blankViewController: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        return vc
    }()
    
    private let tabsCoordinator: TabsCoordinator
    private let loginManager = LoginManager()
    private let window: UIWindow
    private var state: ApplicationState = .empty
    private let colorSchema: ColorSchema
    
    
    init(window: UIWindow) {
        self.window = window
        let schema = AppColorSchema()
        self.colorSchema = schema
        let provider = RealmReviewsProvider()
        self.tabsCoordinator = TabsCoordinator(presenter: tabsRootViewController,
                                               dataprovider: provider,
                                               colorSchema: schema)
        super.init()
        
        
        if loginManager.isUserLoggedIn == true {
            self.presentTabs()
        } else {
            window.rootViewController = blankViewController
        }
    }
    
    private func presentTabs() {
        window.rootViewController = tabsRootViewController
        tabsCoordinator.start()
    }
    
    private func changeRootViewController(_ newViewController: UIViewController,
                                          animationDuration: TimeInterval = 0.3,
                                          animation: UIViewAnimationOptions = .transitionCrossDissolve) {
        
        UIView.transition(with: window, duration: animationDuration, options: animation, animations: {
            self.window.rootViewController = newViewController
        }, completion: { completed in
            // maybe do something here
        })
        
    }

    
}

// MARK: - CelyWindowManagerDelegate
extension ApplicationCoordinator {
    
    func start() {
        ColorSchemaManager.applySchema(schema: colorSchema)
        window.makeKeyAndVisible()
//        let attrs = [
//            NSAttributedStringKey.foregroundColor: UIColor.red
//        ]
//        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
}

