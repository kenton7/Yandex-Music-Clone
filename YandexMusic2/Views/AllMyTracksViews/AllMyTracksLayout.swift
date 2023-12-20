//
//  AllMyTracksLayout.swift
//  YandexMusic2
//
//  Created by Илья Кузнецов on 18.12.2023.
//

import UIKit

class AllMyTracksLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttrubutes = super.layoutAttributesForElements(in: rect)
        
        layoutAttrubutes?.forEach({ attributes in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                print(contentOffsetY)
                
                if contentOffsetY > 0 { // при скроллинге вниз, чтобы header не исчезал резко
                    return
                }
                
                let width = collectionView.frame.width
                let height = attributes.frame.height - contentOffsetY // высота header при скроллинге
                //heder
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        
        return layoutAttrubutes
        
    }
    
    //пересчитывается bounds при скроллинге
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
