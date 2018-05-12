//
//  CharacterFavoriteCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterFavoriteCollectionViewDataSource: NSObject, CharactersCollectionDataSourceInterface {
    var offset: Int?
    var array:NSMutableArray?
    var nibName: String?
    
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, array: NSMutableArray, nibName: String) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.array = array
        self.nibName = nibName
        
        super.init()
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        self.setupCollectionView()
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if((self.array?.count) == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName!, for: indexPath) as! MarvelCharFavoriteCollectionViewCell
        let character = self.array?.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        cell.favoriteImageCharacter.backgroundColor = .lightGray
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.array?.count)!
    }
    
}


class CharacterFavoriteCollectionViewDelegate:NSObject, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/5 - 8,
                          height: collectionView.frame.size.width/5 - 8)
        
    }
}

