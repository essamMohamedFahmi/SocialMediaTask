//
//  FirebaseStorageManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import FirebaseStorage

protocol StorageManagerInjected { }

extension StorageManagerInjected
{
    var storageManager: StorageManager
    {
        get
        {
            return FirebaseStorageManager()
        }
    }
}

class FirebaseStorageManager: StorageManager
{
    // MARK: Methods
    
    func uploadFile(_ data: Data, with name: String,
                    completion: @escaping (Result<String, NetworkError>) -> Void)
    {
        let storageRef = Storage.storage().reference().child(name)
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            
            storageRef.downloadURL { (url, error) in
                
                if let uploadedURL = url?.absoluteString
                {
                    completion(.success(uploadedURL))
                }
                else if let error = error
                {
                    completion(.failure(NetworkError(error)))
                }
            }
        }
    }
}
