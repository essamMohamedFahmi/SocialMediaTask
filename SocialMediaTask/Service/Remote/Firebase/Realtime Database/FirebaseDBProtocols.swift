//
//  FirebaseRealtimeProtocols.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

protocol FirebaseObserverDelegate
{
    // MARK: Methods
    
    func postChanged(_ post: Post)
}
