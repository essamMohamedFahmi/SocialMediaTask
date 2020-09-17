//
//  PostTableViewCell.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate: class
{
    func updatePost(_ post: Post)
}

class PostTableViewCell: UITableViewCell
{
    // MARK: Outlets
    
    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLike: UIButton!

    // MARK: Properties

    weak var delegate: PostTableViewCellDelegate?
    
    private var userLikePost: Bool!
    private var post: Post!
    
    let userID = UserSessionManager.shared.userID ?? ""
    
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
        
        setLikeStatus(post)
        self.post = post
    }
    
    private func setLikeStatus(_ post: Post)
    {
        userLikePost = post.usersLikedPost[userID] ?? false
        if userLikePost
        {
            lblNumberOfLikes.text = "You and \(post.usersLikedPost.count - 1) liked!"
            btnLike.setTitle("Dislike", for: .normal)
        }
        else
        {
            lblNumberOfLikes.text = "\(post.usersLikedPost.count) liked!"
            btnLike.setTitle("Like", for: .normal)
        }
    }
    
    // MARK: Actions
    
    @IBAction func likeButtonTapped(_ sender: UIButton)
    {
        if userLikePost
        {
            post.usersLikedPost[userID] = nil
        }
        else
        {
            post.usersLikedPost[userID] = true
        }
        
        delegate?.updatePost(post)
    }
}

