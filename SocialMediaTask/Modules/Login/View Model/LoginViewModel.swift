//
//  LoginViewModel.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift
import RxCocoa

struct LoginViewModel
{
    // MARK: Properties

    private let _loginProcessDone = BehaviorRelay<Bool?>(value: nil)
    
    var loginProcessDone: Driver<Bool?>
    {
        return _loginProcessDone.asDriver()
    }
    
    // MARK: Methods
    
    func loginAnonymously()
    {
        FirebaseUserSessionManager().login { (result) in
            
            switch result
            {
            case .success(let userID):
                UserSessionManager.shared.setUserLoggedIn(userID)
                self._loginProcessDone.accept(true)
            case .failure:
                self._loginProcessDone.accept(false)
            }
        }
    }
}
