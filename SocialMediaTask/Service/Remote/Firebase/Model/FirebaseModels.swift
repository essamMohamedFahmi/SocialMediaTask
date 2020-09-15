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
    static let likesCount = "likesCount"
    static let usersLikedPost = "usersLikedPost"
}

struct Post: Codable
{
    var ID: String?
    var title: String?
    var description: String?
    var imageURL: String?
    var likesCount: Int?
    var usersLikedPost: [String]?

    enum CodingKeys: String, CodingKey
    {
        case ID, title, description, imageURL, likesCount
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ID = try values.decodeIfPresent(String.self, forKey: .ID)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        likesCount = try values.decodeIfPresent(Int.self, forKey: .likesCount)
    }
    
    init?(_ postInfo: [String: Any])
    {
        guard let title = postInfo[PostInfoKey.title] as? String,
            let description = postInfo[PostInfoKey.description] as? String,
            let imageURL = postInfo[PostInfoKey.imageURL] as? String,
            let likesCount = postInfo[PostInfoKey.likesCount] as? Int,
            let usersLikedPost = postInfo[PostInfoKey.usersLikedPost] as? [String] else { return nil }
        
        self.ID = postInfo[PostInfoKey.ID] as? String ?? ""
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.likesCount = likesCount
        self.usersLikedPost = usersLikedPost
    }
    
    init(title: String, description: String)
    {
        self.title = title
        self.description = description
        self.imageURL = ""
        self.likesCount = 0
        self.usersLikedPost = []
    }
}

