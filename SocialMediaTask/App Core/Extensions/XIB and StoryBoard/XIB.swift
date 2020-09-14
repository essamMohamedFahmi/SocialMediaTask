//
//  XIB.swift
//  collectionViewTestSellection
//
//  Created by fraag on 8/23/19.
//  Copyright © 2019 fraag. All rights reserved.
//

import UIKit

extension UIView
{
    static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    static func instantiateFromNib() -> Self?
    {
        func instanceFromNib<T: UIView>() -> T? {
            return UINib(nibName: "\(self)", bundle: nil).instantiate() as? T
        }
        return instanceFromNib()
    }
}

extension UINib
{
    func instantiate() -> Any?
    {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
