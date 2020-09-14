//
//  DesignableView.swift
//  Taqarir
//
//  Created by Marawan Turky on 1/30/19.
//  Copyright © 2019 Marawan Ahmed AbdelAziz Mohammed Torki. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView
{
    @IBInspectable var fireShadow: Bool = false
        {
        didSet
        {
            if fireShadow
            {
                layer.cornerRadius = 2.0
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.3
                layer.shadowRadius = 3.0
                layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            }
            else
            {
                layer.cornerRadius = 0.0
                layer.shadowColor = UIColor.white.cgColor
                layer.shadowOpacity = 0.0
                layer.shadowRadius = 0.0
                layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }    
} // end of class


