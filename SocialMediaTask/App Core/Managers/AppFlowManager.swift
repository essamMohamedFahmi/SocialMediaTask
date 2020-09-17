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
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    func start()
    {
        UserSessionManager.shared.isLoggedIn ? coordinateToPostsVC() : coordinateToLoginVC()
    }
}

extension AppFlowManager
{
    func coordinateToLoginVC()
    {
        let loginVC = LoginVC.instantiate(storyboard: .login)
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
    
    func coordinateToPostsVC()
    {
        let postsVC = PostsVC.instantiate(storyboard: .posts)
        let navController = UINavigationController(rootViewController: postsVC)
        navController.modalPresentationStyle = .fullScreen
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
