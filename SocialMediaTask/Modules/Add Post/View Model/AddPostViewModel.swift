//
//  AddPostViewModel.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift
import RxCocoa

struct AddPostViewModel: FirebaseNetworkManagerInjected, StorageManagerInjected
{
    // MARK: Properties

    private let _uploadPostProcessDone = BehaviorRelay<Bool?>(value: nil)
    
    var uploadPostProcessDone: Driver<Bool?>
    {
        return _uploadPostProcessDone.asDriver()
    }
    
    // MARK: Methods
    
    func uploadPost(_ post: Post, image: UIImage)
    {
        if let imageData = image.getData()
        {
            Activity.startAnimating()
            storageManager.uploadFile(imageData, with: "photo.jpg") { result in
                
                Activity.stopAnimating()
                switch result
                {
                case .success(let imageURL):
                    
                    var postToUpload = post
                    postToUpload.imageURL = imageURL
                    self.uploadPost(postToUpload)
                    
                case .failure:
                    self._uploadPostProcessDone.accept(false)
                }
            }
        }
    }
    
    private func uploadPost(_ post: Post)
    {
        firebaseNetworkManager.uploadPost(post) { status in
           self._uploadPostProcessDone.accept(status)
        }
    }
}
