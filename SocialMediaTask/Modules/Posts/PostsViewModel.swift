//
//  PostsViewModel.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/15/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift
import RxCocoa

struct PostsViewModel: FirebaseNetworkManagerInjected
{
    // MARK: Properties
    
    private let _posts = BehaviorRelay<[Post]>(value: [])
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var posts: Driver<[Post]>
    {
        return _posts.asDriver()
    }
    
    var error: Driver<String?>
    {
        return _error.asDriver()
    }
    
    var hasError: Bool
    {
        return _error.value != nil
    }
    
    var numberOfPosts: Int
    {
        return _posts.value.count
    }
    
    // MARK: Methods
    
    func getPost(at index: Int) -> Post?
    {
        guard index < _posts.value.count, index >= 0 else
        {
            return nil
        }
        
        return _posts.value[index]
    }
    
    func fetchPosts()
    {
        self._posts.accept([])
        self._error.accept(nil)
        
        firebaseNetworkManager.getPosts
            { (result: Result<[String: Post], NetworkError>) in
                
                switch result
                {
                case .success(let response):
                    
                    if let postsList = self.getPosts(from: response)
                    {
                        self._posts.accept(postsList)
                    }
                    else
                    {
                        self._error.accept("No posts exist!")
                    }
                    
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
        }
    }
    
    private func getPosts(from postsDic: [String: Post]) -> [Post]?
    {
        var postsList: [Post] = []
        for (key, value) in postsDic
        {
            var post = value
            post.ID = key
            postsList.append(post)
        }
        
        guard postsList.count > 0 else { return nil }
        return postsList
    }
}
