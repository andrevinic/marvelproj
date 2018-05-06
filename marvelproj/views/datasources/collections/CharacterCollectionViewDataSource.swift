//
//  CharacterCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class CharacterCollectionViewDataSource: NSObject, CharactersCollectionDataSourceInterface {
    
    var characters:NSMutableArray?
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, characters: NSMutableArray) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.characters = characters
        super.init()
        collectionView.register(UINib(nibName:"CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        self.setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(characters?.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let character = self.characters?.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.characters?.count)!
    }
    
}

class CharacterCollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    weak var delegate: MarvelCharacterDelegate?
    weak var characters: NSMutableArray?
    
    init(_ delegate: MarvelCharacterDelegate, characters: NSMutableArray) {
        self.delegate = delegate
        self.characters = characters
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters?.count)! - 1){
            collectionView.addInfiniteScroll(handler: { (collectionView) in
                self.delegate?.fetchCharacters()
     
            })
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.delegate?.didSelectCharacter(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
}


