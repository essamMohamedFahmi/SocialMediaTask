//
//  PostsTableDataSource.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

protocol PostsTableDataSourceDelegate: class
{
    func updatePost(_ post: Post)
}

public class PostsTableDataSource: NSObject, UITableViewDataSource
{
    // MARK: Properties
    
    private var posts: [Post] = []
    weak var delegate: PostsTableDataSourceDelegate?
    
    // MARK: Class Methods
    
    init(delegate: PostsTableDataSourceDelegate)
    {
        self.delegate = delegate
        super.init()
    }
    
    // MARK: Methods
    
    func setPosts(from posts: [Post])
    {
        self.posts = posts
    }

    // MARK: Data Source Methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeue() as PostTableViewCell
        let post = posts[indexPath.row]
        cell.delegate = self
        cell.configure(post)
        return cell
    }
}


extension PostsTableDataSource: PostTableViewCellDelegate
{
    func updatePost(_ post: Post)
    {
        delegate?.updatePost(post)
    }
}
