//
//  CharactersCollectionDataSourceInterface.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

protocol CharactersCollectionDataSourceInterface: UICollectionViewDataSource {
    //    public var context: NSManagedObjectContext? {get}
    
    var array:NSMutableArray? {get}
    var nibName:String? {get}

    weak var collectionView: UICollectionView? {get}
    weak var delegate: UICollectionViewDelegate? {get}
    
    init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, array: NSMutableArray, nibName: String)
    
    func setupCollectionView()
}

extension CharactersCollectionDataSourceInterface{
    func setupCollectionView(){
        
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
}

