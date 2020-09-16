//
//  FirebaseObserverManager.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import FirebaseDatabase

class FirebaseObserverManager
{
    // MARK: Properties
    
    var delegate: FirebaseObserverDelegate
    
    private var post: Post? = nil
    {
        didSet
        {
            guard let post = post else { return }
            delegate.postChanged(post)
        }
    }
    
    enum ChatDBCoreReference
    {
        static let posts = "posts"
    }
    
    // MARK: Firebase Database References
    
    private let postsReference = Database.database().reference().child(ChatDBCoreReference.posts)

    // MARK: Init
    
    required init(delegate: FirebaseObserverDelegate)
    {
        self.delegate = delegate
        observeForChangeInPosts()
    }
    
    deinit
    {
        postsReference.removeAllObservers()
    }
    
    // MARK: Methods
    
    private func observeForChangeInPosts()
    {
        postsReference.observe(.childChanged) { [weak self] child in
            
            let postID = child.key
            var postInfo = child.value as? [String: Any] ?? [:]
            postInfo[PostInfoKey.ID] = postID
            
            if let post = Post(postInfo)
            {
                self?.post = post
            }
        }
    }
}
