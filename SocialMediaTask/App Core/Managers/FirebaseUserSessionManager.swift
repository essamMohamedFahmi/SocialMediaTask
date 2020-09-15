//
//  FirebaseUserSessionManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import FirebaseAuth

class FirebaseUserSessionManager
{
    // MARK: Init
    
    private init() { }

    // MARK: Properties
    
    static var shared = FirebaseUserSessionManager()
    private(set) var userID: String?
    
    // MARK: Methods
    
    func login(completion: @escaping (Bool) -> Void)
    {
        let auth = Auth.auth()
        auth.signInAnonymously { [weak self] (authResult, error) in
            
            guard let user = authResult?.user else
            {
                completion(false)
                return
            }
            
            self?.userID = user.uid
            completion(true)
        }
    }
}
