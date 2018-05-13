//
//  CharacterCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterCollectionViewDataSource: NSObject, CharactersCollectionDataSourceInterface {
    
    var array:NSMutableArray?
    var nibName:String?
    var favoriteChars: NSMutableArray?
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    required init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, array: NSMutableArray, nibName: String, favoriteChars: NSMutableArray) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.array = array
        self.nibName = nibName
        self.favoriteChars = favoriteChars
        
        super.init()
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        self.setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(array?.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.nibName!, for: indexPath) as! CharacterCollectionViewCell
        let character = self.array?.object(at: indexPath.row) as! Character
        if(self.favoriteChars?.count == 0){
            cell.favoriteButton.isHidden = true
        }
        cell.setupCell(char: character)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.array?.count)!
    }
    
}

class CharacterCollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    weak var delegate: MarvelCharacterDelegate?
    weak var characters: NSMutableArray?
    var numberOfCellsInRow: Int = 0
    
    init(_ delegate: MarvelCharacterDelegate, characters: NSMutableArray, numberOfCellsInRow: Int) {
        self.delegate = delegate
        self.characters = characters
        self.numberOfCellsInRow = numberOfCellsInRow
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters?.count)! - 1){
            self.delegate?.fetchCharacters()

        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.delegate?.didSelectCharacter(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        let numberOfCells = CGFloat(self.numberOfCellsInRow)
        let width = collectionViewSize / numberOfCells
        return CGSize(width: width, height: width)
        
//        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
    
//    collectionview
}


