//
//  FirebaseTest.swift
//  Rakeb user
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Moya

enum FirebaseAPI
{
    case posts
    case uploadPost(_ post: Post)
}

extension FirebaseAPI: TargetType
{
    var baseURL: URL
    {
        return URL(string: "https://socialmediatask-a6244.firebaseio.com")!
    }
    
    var path: String
    {
        switch self
        {
        case .posts, .uploadPost:
            return "/posts.json"
        }
    }
    
    var method: Moya.Method
    {
        switch self
        {
        case .posts:
            return .get
        case .uploadPost:
            return .post
        }
    }
    
    var sampleData: Data
    {
        switch self
        {
        default:
            return Data()
        }
    }
    
    var headers: [String: String]?
    {
        return nil
    }
    
    var task: Task
    {
        switch self
        {
        case .posts:
            var parameters: [String: Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .uploadPost(let post):
            var parameters: [String: Any] = [:]
            parameters["text"] = "done"
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
