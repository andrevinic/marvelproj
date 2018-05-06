//
//  CharactersCollectionDataSourceInterface.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

protocol CharactersCollectionDataSourceInterface: UICollectionViewDataSource {

    var characters:NSMutableArray? {get}
    weak var collectionView: UICollectionView? {get}
    weak var delegate: UICollectionViewDelegate? {get}
    
    init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, characters: NSMutableArray)
    
    func setupCollectionView()
}

extension CharactersCollectionDataSourceInterface{
    func setupCollectionView(){
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        self.collectionView?.reloadData()
//
//        let layout = AnimatedCollectionViewLayout()
//        layout.animator = LinearCardAttributesAnimator()
//
//        self.collectionView?.collectionViewLayout = layout
    }
    
}
