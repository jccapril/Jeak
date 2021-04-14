//
//  CarouseViewFlowLayout.swift
//  App
//
//  Created by Flutter on 2021/4/13.
//

import UIKit

class CarouseViewFlowLayout: UICollectionViewFlowLayout {
    var isZoom: Bool = false
}

// MARK: - Override
extension CarouseViewFlowLayout {
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        let centerX = self.collectionView!.contentOffset.x + self.collectionView!.bounds.size.width * 0.5
        return attributes?.map {
            let attr = $0.copy() as! UICollectionViewLayoutAttributes
            if self.isZoom {
                let distance: Float = fabsf(Float(attr.center.x - centerX))
                let factor: Float = 0.0005
                let scale: CGFloat = CGFloat(1 / (1 + distance * factor))
                attr.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            return attr
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
