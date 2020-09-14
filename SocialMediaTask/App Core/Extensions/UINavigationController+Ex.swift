//
//  UINavigationController+Ex.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func popToSpecificVC(vc: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: vc))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
    func setStatusBarBackgroundColor(color:UIColor){
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
                statusBar.backgroundColor = color
                UIApplication.shared.keyWindow?.addSubview(statusBar)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.statusBarView?.backgroundColor = color
            }
        }
    }
}

extension UINavigationItem{

    override open func awakeFromNib() {
        super.awakeFromNib()
        let backItem = UIBarButtonItem()
        backItem.title = "Back".localized
        backItem.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.roboto(.regular(14))], for: .normal)
        /*Changing color*/
        backItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

        self.backBarButtonItem = backItem
    }

}
