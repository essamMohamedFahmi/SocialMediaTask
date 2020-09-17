//
//  FirebaseNetworkManager.swift
//  Rakeb user
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Moya

struct FirebaseNetworkManagerInjectionMap
{
   static var firebaseNetworkManager = FirebaseNetworkManager()
}

protocol FirebaseNetworkManagerInjected { }

extension FirebaseNetworkManagerInjected
{
    var firebaseNetworkManager: FirebaseNetworkable
    {
        get
        {
            return FirebaseNetworkManagerInjectionMap.firebaseNetworkManager
        }
    }
}

class FirebaseNetworkManager: FirebaseNetworkable
{
    // MARK: Properties
    
    private let provider: MoyaProvider<FirebaseAPI>
    
    // MARK: Initiallization
    
    init(provider: MoyaProvider<FirebaseAPI>)
    {
        self.provider = provider
    }
    
    convenience init()
    {
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure =
        { (activity, _) in
            switch activity
            {
            case .began:
                Activity.startAnimating()
            case .ended:
                Activity.stopAnimating()
            }
        }
            
        var plugins: [PluginType] = []

        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        plugins.append(networkActivityPlugin)
        
        let networkLogger = NetworkLoggerPlugin()
        plugins.append(networkLogger)
        
        let provider = MoyaProvider<FirebaseAPI>(plugins: plugins)
        self.init(provider: provider)
    }
    
    // MARK: Private Methods
    
    // MARK: Methods
    
    func getPosts(
        completion: @escaping (Result<[String: Post], NetworkError>) -> Void)
    {
        provider.request(.posts) { result in
            
            switch result
            {
            case .success(let value):
                let decoder = JSONDecoder()
                do
                {
                    let response = try decoder.decode([String: Post].self, from: value.data)
                    completion(.success(response))
                }
                catch let error
                {
                    completion(.failure(NetworkError(error)))
                }
                
            case .failure(let error):
                completion(.failure(NetworkError(error)))
            }
        }
    }
    
    func uploadPost(_ post: Post, completion: @escaping (Bool) -> Void)
    {
        provider.request(.uploadPost(post)) { result in
            
            if case .success = result
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    func updatePost(_ post: Post, completion: @escaping (Bool) -> Void)
    {
        // we do not want to animate while update post
        Activity.stopWorking(true)
        
        provider.request(.updatePost(post)) { result in
            
            if case .success = result
            {
                completion(true)
            }
            else
            {
                completion(false)
            }
            
            Activity.stopWorking(false)
        }
    }
}
