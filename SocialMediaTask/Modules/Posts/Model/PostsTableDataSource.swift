//
//  PostsTableDataSource.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

public class PostsTableDataSource: NSObject, UITableViewDataSource
{
    // MARK: Properties
    
    private var posts: [Post] = []
    
    // MARK: Class Methods
    
    init(_ posts: [Post])
    {
        self.posts = posts
        super.init()
    }

    // MARK: Data Source Methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 320
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeue() as PostTableViewCell
        let post = posts[indexPath.row]
        cell.configure(post)
        return cell
    }
}
