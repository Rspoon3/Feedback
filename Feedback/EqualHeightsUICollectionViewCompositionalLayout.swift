//
//  EqualHeightsUICollectionViewCompositionalLayout.swift
//  UIKitTesting
//
//  Created by Richard Witherspoon on 6/8/22.
//

import UIKit

class EqualHeightsUICollectionViewCompositionalLayout: UICollectionViewCompositionalLayout{
    var largestDict: [Int: CGFloat] = [:]
    let columns = 3

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        if let attributes = attributes {
            for attribute in attributes {
                let height = attribute.frame.height
                let row = attribute.indexPath.row / columns
                
                if height > 1 {
                    self.largestDict[row] = max(height, largestDict[row] ?? 0)
                }
            }
        }
        
        return attributes
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        largestDict.removeAll()
    }
}
