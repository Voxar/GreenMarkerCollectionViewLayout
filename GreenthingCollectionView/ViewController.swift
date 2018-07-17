//
//  ViewController.swift
//  GreenthingCollectionView
//
//  Created by Patrik Sjöberg on 2018-07-17.
//  Copyright © 2018 Patrik Sjöberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: GreenThinkLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.red
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        collectionView.frame = CGRect(x: 0, y: view.frame.height/2 - 100, width: view.bounds.width, height: 200)
        
        collectionView.selectItem(at: IndexPath(item: 4, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 200, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? Cell {
            cell.backgroundColor = UIColor.gray
            cell.label.text = "Option \(indexPath.item)"
        }
        return cell
    }
    
    class Cell: UICollectionViewCell {
        lazy var label: UILabel = {
            let view = UILabel()
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.frame = contentView.bounds
            contentView.addSubview(view)
            return view
        }()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for ip in collectionView.indexPathsForSelectedItems ?? [] where ip != indexPath {
            collectionView.deselectItem(at: ip, animated: true)
        }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        UIView.animate(withDuration: 0.2) {
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.layoutSubviews()
        }
    }
    

}

