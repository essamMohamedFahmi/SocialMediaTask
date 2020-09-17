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
    case updatePost(_ post: Post)
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
        case .updatePost(let post):
            return "/posts/\(post.ID).json"
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
        case .updatePost:
            return .put
        }
    }
    
    var sampleData: Data
    {
        switch self
        {
        case .posts:
            return FirebaseTestingManager.shared.getJSONData()
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
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
        case .uploadPost(let post):
            let parameters = getParameters(from: post)
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updatePost(let post):
            let parameters = getParameters(from: post)
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}

extension FirebaseAPI
{
    func getParameters(from post: Post) -> [String: Any]
    {
        var parameters: [String: Any] = [:]
        parameters[PostInfoKey.title] = post.title
        parameters[PostInfoKey.description] = post.description
        parameters[PostInfoKey.imageURL] = post.imageURL
        parameters[PostInfoKey.usersLikedPost] = post.usersLikedPost
        return parameters
    }
}
