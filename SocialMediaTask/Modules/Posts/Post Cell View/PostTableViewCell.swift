//
//  PostTableViewCell.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell
{
    // MARK: Outlets
    
    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: Properties

    // MARK: Class Methods
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    
    func configure(_ post: Post)
    {
        imageViewPost.uploadImage(from: post.imageURL)
        lblTitle.text = post.title
        lblDescription.text = post.description
        lblNumberOfLikes.text = "\(post.likesCount ?? 0) liked it!"
    }
    
    // MARK: Actions
    
    @IBAction func likeTapped(sender: UIButton)
    {
        
    }
}

