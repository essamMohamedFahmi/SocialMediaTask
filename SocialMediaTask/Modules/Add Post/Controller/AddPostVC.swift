//
//  AddPostVC.swift
//  SocialMediaTask
//
//  Created by Essam Mohamed Fahmi on 9/16/20.
//  Copyright © 2020 Essam Mohamed Fahmi. All rights reserved.
//

import RxSwift
import GrowingTextView
import TLPhotoPicker

class AddPostVC: UIViewController
{
    // MARK: Outlets
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var textViewDescription: GrowingTextView!
    @IBOutlet weak var imageViewPostImage: UIImageView!
    @IBOutlet weak var btnRemoveImage: UIButton!
    @IBOutlet weak var stackViewPost: UIStackView!
    
    // MARK: Properties
    
    var viewModel: AddPostViewModel!
    private let disposeBag = DisposeBag()
    
    var galleryPickerVC: TLPhotosPickerViewController = TLPhotosPickerViewController()
    
    // MARK: View Controller Life Cycle
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        setup()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: Methods
    
    private func setup()
    {
        self.navigationItem.title = "Add Post"
        
        imageViewPostImage.isHidden = true
        btnRemoveImage.isHidden = true
        
        setupGalleryPicker()
        initViewModel()
    }
    
    private func initViewModel()
    {
        viewModel = AddPostViewModel()
        
        viewModel.uploadPostProcessDone.drive(onNext: { [weak self] (status) in
            
            guard let status = status else { return }
            if status
            {
                NotifiyMessage.shared.toast(toastMessage: "Post shared successfully!")
                {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            else
            {
                NotifiyMessage.shared.toast(toastMessage: "Please try again!")
            }
        }).disposed(by: disposeBag)
    }
    
    private func showPostImage(_ isVisible: Bool)
    {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: { [weak self] in
                        self?.imageViewPostImage.isHidden = !isVisible
                        self?.btnRemoveImage.isHidden = !isVisible
                        self?.stackViewPost.layoutIfNeeded()
            }, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func sharePostButtonTapped(_ sender: Any)
    {
        guard let title = txtTitle.text,
            let description = textViewDescription.text,
            let image = imageViewPostImage.image else
        {
            return
        }
        
        let post = Post(title: title, description: description)
        viewModel.uploadPost(post, image: image)
    }
    
    @IBAction func imageButtonTapped(_ sender: Any)
    {
        openGallery()
    }
    
    @IBAction func removeImageButtonTapped(_ sender: Any)
    {
        imageViewPostImage.image = nil
        showPostImage(false)
    }
}

extension AddPostVC: TLPhotosPickerViewControllerDelegate
{
    func openGallery()
    {
        present(galleryPickerVC, animated: true, completion: nil)
    }
    
    func setupGalleryPicker()
    {
        var configure = TLPhotosPickerConfigure()
        configure.allowedLivePhotos = false
        configure.allowedVideo = false
        configure.allowedVideoRecording = false
        configure.maxSelectedAssets = 1
        
        galleryPickerVC.configure = configure
        galleryPickerVC.delegate = self
    }
    
    // MARK: TLPhotosPickerViewControllerDelegate
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset])
    {
        for asset in withTLPHAssets
        {
            if asset.type == .photo
            {
                if let image = asset.fullResolutionImage
                {
                    imageViewPostImage.image = image
                }
            }
        }
    }
    
    func dismissComplete()
    {
        if imageViewPostImage.image != nil
        {
            showPostImage(true)
        }
    }
}
