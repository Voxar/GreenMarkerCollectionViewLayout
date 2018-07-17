//
//  GreenThingLayout.swift
//  GreenthingCollectionView
//
//  Created by Patrik Sjöberg on 2018-07-17.
//  Copyright © 2018 Patrik Sjöberg. All rights reserved.
//

import UIKit

class GreenThinkLayout: UICollectionViewFlowLayout {
    
    let greenAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "green", with: IndexPath(item: 0, section: 0))
    
    override func prepare() {
        super.prepare()
        
        register(GreenTriangle.self, forDecorationViewOfKind: "green")
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let superAttributes = super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
        if elementKind == "green", indexPath == IndexPath(item: 0, section: 0) {
            greenAttributes.frame = greenFrame
            return greenAttributes
        }
        return superAttributes
    }
    
    var greenFrame: CGRect {
        guard
            let indexPath = selectedIndexPath,
            let itemAttributes = layoutAttributesForItem(at: indexPath)
            else { return .zero }
        
        return CGRect(
            x: itemAttributes.center.x - 25/2,
            y: itemAttributes.frame.maxY,
            width: 25,
            height: 25
        )
    }
    
    var selectedIndexPath: IndexPath? {
        return collectionView?.indexPathsForSelectedItems?.first
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superAttributes = super.layoutAttributesForElements(in: rect)
        greenAttributes.frame = greenFrame
        if greenAttributes.frame.intersects(rect) {
            return (superAttributes ?? []) + [greenAttributes]
        }
        return superAttributes
    }
    
    class GreenTriangle: UICollectionReusableView {
        override func layoutSubviews() {
            super.layoutSubviews()
            backgroundColor = UIColor.green
        }
    }
}
