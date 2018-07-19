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
    let supplementaryAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "supplementary", with: IndexPath(item: 1, section: 0))

    
    override func prepare() {
        super.prepare()
        
        register(TriangleView.self, forDecorationViewOfKind: "green")
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
            height: 20
        )
    }

    var supplementaryFrame: CGRect {
        guard
            let indexPath = selectedIndexPath,
            let itemAttributes = layoutAttributesForItem(at: indexPath)
            else { return .zero }

        return CGRect(
            x: itemAttributes.center.x - 25/2,
            y: itemAttributes.frame.minY,
            width: 25,
            height: 20
        )
    }
    
    var selectedIndexPath: IndexPath? {
        return collectionView?.indexPathsForSelectedItems?.first
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var superAttributes = super.layoutAttributesForElements(in: rect) ?? []

        greenAttributes.frame = greenFrame
        if greenAttributes.frame.intersects(rect) {
            superAttributes + [greenAttributes]
        }

        supplementaryAttributes.frame = supplementaryFrame

        if supplementaryAttributes.frame.intersects(rect) {
            return superAttributes + [supplementaryAttributes]
        }
        return superAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    

    
    class GreenTriangle: UICollectionReusableView {
        override func layoutSubviews() {
            super.layoutSubviews()
            backgroundColor = UIColor.green
        }
    }
}

class TriangleView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: CGPoint(x: rect.midX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        context.closePath()
        context.setFillColor(UIColor.green.cgColor)
        context.fillPath()
    }

    override var intrinsicContentSize: CGSize {
        return frame.size
    }
}
