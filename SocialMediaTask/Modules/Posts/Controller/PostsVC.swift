//
//  PostsVC.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/14/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift

class PostsVC: UIViewController
{
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    
    private var viewModel: PostsViewModel!
    private let disposeBag = DisposeBag()

    private var dataSource: UITableViewDataSource!
    private var delegate: UITableViewDelegate!
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        viewModel.fetchPosts()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        initPostsTableView()
        initViewModel()
    }
    
    // MARK: Methods
    
    private func initViewModel()
    {
        viewModel = PostsViewModel()
        
        viewModel.posts.drive(onNext: { [weak self] (posts) in
            self?.refreshDataSource(with: posts)
        }).disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: { [weak self] (_) in
            if self?.viewModel.hasError ?? false
            {
                NotifiyMessage.shared.toast(toastMessage: "Please try again!")
            }
        }).disposed(by: disposeBag)
    }
    
    private func initPostsTableView()
    {
        delegate = PostsTableDelegate(parentViewController: self) as UITableViewDelegate
        tableView.delegate = delegate
        
        dataSource = PostsTableDataSource(delegate: self) as UITableViewDataSource
        tableView.dataSource = dataSource
        
        tableView.register(cell: PostTableViewCell.self)
        tableView.removeEmptyCells()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 320
    }
    
    private func refreshDataSource(with posts: [Post])
    {
        (dataSource as! PostsTableDataSource).setPosts(from: posts)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func addPostButtonTapped(_ sender: Any)
    {
        //
    }
}

extension PostsVC: PostsTableDataSourceDelegate
{
    func updatePost(_ post: Post)
    {
        viewModel.updatePost(post)
    }
}

