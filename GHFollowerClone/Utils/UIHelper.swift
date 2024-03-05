//
//  UIHelper.swift
//  GHFollowerClone
//
//  Created by DucLong on 05/03/2024.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewLayout {
        let width                                   = view.bounds.width
        let padding: CGFloat                        = 12
        let minimumItemSpacing: CGFloat             = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
