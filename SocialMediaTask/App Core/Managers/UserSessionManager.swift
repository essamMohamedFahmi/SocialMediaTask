//
//  UserSessionManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/17/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

public class UserSessionManager
{
    // MARK: Properties
    
    static var shared = UserSessionManager()
    
    enum UserSessionKey
    {
        static let userID = "userID"
        static let isLoggedIn = "isLoggedIn"
    }
    
    var isLoggedIn: Bool
    {
        return UserDefaults.standard.bool(forKey: UserSessionKey.isLoggedIn)
    }
    
    var userID: String?
    {
        return UserDefaults.standard.string(forKey: UserSessionKey.userID)
    }
    
    // MARK: Init
    
    private init(){}
    
    // MARK: Methods
    
    func setUserLoggedIn(_ ID: String)
    {
        UserDefaults.standard.set(ID, forKey: UserSessionKey.userID)
        UserDefaults.standard.set(true, forKey: UserSessionKey.isLoggedIn)
        UserDefaults.standard.synchronize()
    }
}
