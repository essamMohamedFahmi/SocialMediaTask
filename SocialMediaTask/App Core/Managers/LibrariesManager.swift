//
//  LibrariesManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import IQKeyboardManagerSwift

class LibrariesManager
{
    private init() { }
    
    static func initLibraries(for application: UIApplication,
                              launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    {
        NotifiyMessage.shared.configNotify()
        enableKeyboardManager()
    }
    
    private static func enableKeyboardManager()
    {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
