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
    // MARK: Methods
    
    func login(completion: @escaping (Result<String, NetworkError>) -> Void)
    {
        let auth = Auth.auth()
        auth.signInAnonymously { (authResult, error) in
            
            if let userID = authResult?.user.uid
            {
                completion(.success(userID))
            }
            else if let error = error
            {
                completion(.failure(NetworkError(error)))
            }
        }
    }
}
