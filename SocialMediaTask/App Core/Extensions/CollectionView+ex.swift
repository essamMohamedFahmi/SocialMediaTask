//
//  CollectionViewCell.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UICollectionViewCell: IdentifiableCell {
    static var CellIdentifier: String {
        return "\(self)"
    }
    
    
}
extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return self.next(of: UICollectionView.self)
    }
    
    var indexPath: IndexPath? {
        return self.collectionView?.indexPath(for: self)
    }
}

extension UICollectionView {
    func register<T>(cell: T.Type) where T: UICollectionViewCell  {
        register(cell.nib, forCellWithReuseIdentifier: cell.CellIdentifier)
    }
    func scrollToNextItem() {
        scrollToItem(at: IndexPath(row: visibleCurrentCellIndexPath! + 1, section: 0), at: .right, animated: true)
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
    
    var visibleCurrentCellIndexPath: Int? {
        for cell in visibleCells {
            let indexPath = self.indexPath(for: cell)
            return indexPath?.row
        }
        
        return nil
    }
    
    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
    
    func adjustForLang(){
        if LocalizationManager.currentLangauge() != "ar"
        {
            semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
        }
        else
        {
            semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        }
        
    }
}
extension UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return LocalizationManager.isArabicLang()
    }
}

