//
//  LoginVC.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift

class LoginVC: UIViewController
{
    // MARK: Properties

    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initViewModel()
    }
    
    // MARK: Methods
    
    private func initViewModel()
    {
        viewModel = LoginViewModel()
        
        viewModel.loginProcessDone.drive(onNext: { [weak self] (status) in
            guard let status = status else { return }
            status ? self?.segueToPostsScreen() :
                NotifiyMessage.shared.toast(toastMessage: "Can not login!")
        }).disposed(by: disposeBag)
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        viewModel.loginAnonymously()
    }
}

extension LoginVC
{
    private func segueToPostsScreen()
    {
        let postsVC = PostsVC.instantiate(storyboard: .posts)
        let navController = UINavigationController(rootViewController: postsVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
}
