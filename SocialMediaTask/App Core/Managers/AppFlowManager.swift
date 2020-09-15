//
//  AppFlowManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

class AppFlowManager
{
    private var window: UIWindow?
    
    func start()
    {
        coordinateToLoginVC()
    }
}

extension AppFlowManager
{
    func coordinateToLoginVC()
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = LoginVC.instantiate(storyboard: .login)
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
    }
}
