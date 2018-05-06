//
//  CharacterCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class CharacterCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var characters:NSMutableArray!
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    var offset : Int = 0
    var limit: Int = 10
    
    init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, characters: NSMutableArray) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.characters = characters
        super.init()
        collectionView.register(UINib(nibName:"CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        self.setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(characters.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let character = self.characters.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters.count) - 1){
            collectionView.addInfiniteScroll(handler: { (collectionView) in
//                                self.fetchCharacters()
            
            })
        }
    }
}

class CharacterCollectionViewDelegate:NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    let delegate: MarvelCharacterDelegate
    
    init(_ delegate: MarvelCharacterDelegate) {
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewSize = collectionView.frame.size.width
            return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
}

extension CharacterCollectionViewDataSource{
    func setupCollectionView(){
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        self.collectionView?.reloadData()
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator()

        self.collectionView?.collectionViewLayout = layout
    }
}


