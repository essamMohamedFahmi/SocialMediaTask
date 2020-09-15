//
//  PostsTableDelegate.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import UIKit

public class PostsTableDelegate: NSObject, UITableViewDelegate
{
    // MARK: Properties
    
    let parentViewController: UIViewController!

    // MARK: Class Methods
    
    init(parentViewController: UIViewController)
    {
        self.parentViewController = parentViewController
        super.init()
    }

    // MARK: Table Delegate Methods
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
