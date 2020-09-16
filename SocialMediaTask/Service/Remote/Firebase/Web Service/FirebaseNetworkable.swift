//
//  FirebaseNetworkable.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

protocol FirebaseNetworkable: class
{
    // MARK: Methods
    
    func getPosts(
        completion: @escaping (Result<[String: Post], NetworkError>) -> Void)
    
    func uploadPost(_ post: Post,
                    completion: @escaping (Bool) -> Void)
    
    func updatePost(_ post: Post,
                    completion: @escaping (Bool) -> Void)
}
