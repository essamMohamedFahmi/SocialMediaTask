
//
//  StorageManagerProtocols.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

public protocol StorageManager
{
    // MARK: Methods
    
    func uploadFile(_ data: Data, with name: String,
                    completion: @escaping (Result<String, NetworkError>) -> Void)
}
