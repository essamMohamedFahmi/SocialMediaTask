//
//  PostsVCExtensions.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/17/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

// MARK: PostsTableDataSourceDelegate

extension PostsVC: PostsTableDataSourceDelegate
{
    func updatePost(_ post: Post)
    {
        viewModel.updatePost(post)
    }
}

// MARK: Refresh Control

extension PostsVC
{
    func setupRefreshControl()
    {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl)
    {
        if sender.isRefreshing
        {
            viewModel.fetchPosts()
        }
    }
    
    func stopPullAnimation()
    {
        tableView.refreshControl?.endRefreshing()
    }
}

