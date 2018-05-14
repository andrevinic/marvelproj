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
    var array:[Character] = []
    var nibName: String?
    
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, array: [Character], nibName: String) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.array = array
        self.nibName = nibName
        
        super.init()
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        self.setupCollectionView()
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(self.array.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName!, for: indexPath) as! MarvelCharFavoriteCollectionViewCell
        let character = self.array[indexPath.row]
        cell.setupCell(char: character)
        cell.favoriteImageCharacter.backgroundColor = .lightGray
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.array.count
    }
    
}


class CharacterFavoriteCollectionViewDelegate:NSObject, UICollectionViewDelegateFlowLayout{

    weak var delegate: MarvelCharacterDelegate?
    
    init(delegate: MarvelCharacterDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/5 - 8,
                          height: collectionView.frame.size.width/5 - 8)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectCharacterFavorite(index: indexPath)
    }
}

