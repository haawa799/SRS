//
//  TabsCoordinator.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/21/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit

protocol TabsCoordinatorDelegate: class {
    func logOutPressed()
}

open class TabsCoordinator: Coordinator {
    
    weak var delegate: TabsCoordinatorDelegate?
    
    fileprivate let dashboardNavigationController: UINavigationController
    fileprivate let dashboardCoordinator: DashboardCoordinator
    
    let presenter: UITabBarController
    
    init(presenter: UITabBarController, dataprovider: ReviewsProvider, colorSchema: ColorSchema) {
        self.presenter = presenter
        self.dashboardNavigationController = UINavigationController()//AppNavigationController(colorSchema: colorSchema)
        self.dashboardCoordinator = DashboardCoordinator(presenter: dashboardNavigationController,
                                                         dataprovider: dataprovider,
                                                         colorSchema: colorSchema)
        
        presenter.viewControllers = [dashboardNavigationController]
    }
    
}

// MARK: - Coordinator
extension TabsCoordinator {
    func start() {
        dashboardCoordinator.start()
    }
    
}

