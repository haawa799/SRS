//
//  DashboardCoordinator.swift
//  SRS
//
//  Created by Andrii Kharchyshyn on 2/21/18.
//  Copyright © 2018 Andrii Kharchyshyn. All rights reserved.
//

import UIKit

class DashboardCoordinator: Coordinator {
    
    struct Constants {
        static let dashboardTitle = "Dashboard"
    }
    
    let presenter: UINavigationController
    let dashboardViewController: UIViewController
    
    init(presenter: UINavigationController, dataprovider: ReviewsProvider, colorSchema: ColorSchema) {
        self.presenter = presenter
        self.dashboardViewController = ReviewItemsViewController(dataprovider: dataprovider,
                                                                 colorSchema: colorSchema)
        dashboardViewController.view.backgroundColor = .blue
    }
    
    func start() {
        presenter.pushViewController(dashboardViewController, animated: false)
    }
    
}

// MARK: - DashboardViewControllerDelegate
extension DashboardCoordinator {
    
}

