//
//  UIImageView+Blur.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView
{
    func addBlurEffect(_ blurStyle: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.center = self.center
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImageView
{
    convenience init(assetName : String, scale : UIView.ContentMode = .scaleAspectFit)
    {
        self.init(image: UIImage(named: assetName))
        contentMode = scale
    }
    
    func nuke(url: String?, placeHolder: String = "")
    {
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: placeHolder),
            transition: .fadeIn(duration: 0.5),
            contentModes: .init(
                success: .scaleAspectFill,
                failure: .scaleAspectFill,
                placeholder: .scaleAspectFill
            )
        )
        
        if let URL = URL(string: url!) {
            DispatchQueue.main.async {
               Nuke.loadImage(with: ImageRequest(url: URL), options: options, into: self, progress: nil, completion: nil)
            }
        }
    }
    
    func nuke(url : String?,placeHolder : String = "",_ completion: @escaping(_ status:Bool)->())
    {
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: placeHolder),
            transition: .fadeIn(duration: 0.5),
            contentModes: .init(
                success: .scaleAspectFill,
                failure: .scaleAspectFill,
                placeholder: .scaleAspectFill
            )
        )
        
        if let URL = URL(string: url!) {
            DispatchQueue.main.async {
                Nuke.loadImage(with: ImageRequest(url: URL), options: options, into: self, progress: nil) { (result) in
                    switch result{
                    case .success:
                        completion(true)
                    case .failure:
                        completion(false)
                    }
                }
            }
        }
    }
}

