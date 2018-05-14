//
//  CharacterCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterCollectionViewDataSource: NSObject, CharactersCollectionDataSourceInterface {
    
    var array:[Character] = []
    var nibName:String?
    var favoriteChars: [Character] = []
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
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(array.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.nibName!, for: indexPath) as! CharacterCollectionViewCell
        let character = self.array[indexPath.row]
        if(self.favoriteChars.count == 0){
            cell.favoriteButton.isHidden = true
        }
        cell.setupCell(char: character)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.array.count
    }
    
}

class CharacterCollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    weak var delegate: MarvelCharacterDelegate?
    
    var characters: [Character] = []
    var numberOfCellsInRow: Int = 0
    
    init(_ delegate: MarvelCharacterDelegate, characters: [Character], numberOfCellsInRow: Int) {
        self.delegate = delegate
        self.characters = characters
        self.numberOfCellsInRow = numberOfCellsInRow
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == self.characters.count - 1){
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
        
    }
}


