//
//  RootCoordinator.swift
//  test-app
//
//  Created by Zac on 16/02/2019.
//  Copyright © 2019 zac-gil. All rights reserved.
//

import Foundation
import UIKit

class RootCoodinator: Coordinator {
    fileprivate var window: UIWindow?
    
    fileprivate var navigationController: TSTNavigationController?
    
    func startApp() {
        self.navigationController = TSTNavigationController()
        self.window?.rootViewController = self.navigationController
        self.createMainUI()
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension RootCoodinator {
    fileprivate func createMainUI() {
        guard let navController = self.navigationController else {
            print("No nav controller in createMainUI()")
            return
        }
        
        let vc = TestMainViewController()
        
        navController.pushViewController(vc, animated: false)
    }
}
