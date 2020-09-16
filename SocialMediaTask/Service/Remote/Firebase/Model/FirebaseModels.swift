//
//  FirebaseModels.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import Foundation

enum PostInfoKey
{
    static let ID = "ID"
    static let title = "title"
    static let description = "description"
    static let imageURL = "imageURL"
    static let usersLikedPost = "usersLikedPost"
}

struct Post: Codable
{
    var ID: String = ""
    var title: String = ""
    var description: String = ""
    var imageURL: String = ""
    var usersLikedPost: [String: Bool] = [:]

    enum CodingKeys: String, CodingKey
    {
        case ID, title, description, imageURL, usersLikedPost
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ID = try values.decodeIfPresent(String.self, forKey: .ID) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        usersLikedPost =
            try values.decodeIfPresent([String: Bool].self, forKey: .usersLikedPost) ?? [:]
    }
    
    init?(_ postInfo: [String: Any])
    {
        guard let title = postInfo[PostInfoKey.title] as? String,
            let description = postInfo[PostInfoKey.description] as? String,
            let imageURL = postInfo[PostInfoKey.imageURL] as? String
            else { return nil }
        
        self.ID = postInfo[PostInfoKey.ID] as? String ?? ""
        self.usersLikedPost = postInfo[PostInfoKey.usersLikedPost] as? [String: Bool] ?? [:]
        
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
    
    init(title: String, description: String)
    {
        self.title = title
        self.description = description
        self.imageURL = ""
        self.usersLikedPost = [:]
    }
}
