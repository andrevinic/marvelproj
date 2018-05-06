//
//  CharacterFavoriteCollectionViewDataSource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class CharacterFavoriteCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var characters:NSMutableArray!
    weak var collectionView: UICollectionView?
    weak var delegate: UICollectionViewDelegate?
    
    init(collectionView: UICollectionView, delegate: UICollectionViewDelegate, characters: NSMutableArray) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.characters = characters
        super.init()
        collectionView.register(UINib(nibName:"MarvelCharFavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MarvelCharFavoriteCollectionViewCell")
        self.setupFavoriteCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(self.characters.count == 0){
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarvelCharFavoriteCollectionViewCell", for: indexPath) as! MarvelCharFavoriteCollectionViewCell
        let character = self.characters.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        cell.favoriteImageCharacter.backgroundColor = .lightGray
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.characters.count
    }
    
}

extension CharacterFavoriteCollectionViewDataSource{
    func setupFavoriteCollectionView(){
        self.collectionView?.isHidden = false
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self.delegate
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ZoomInOutAttributesAnimator()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.collectionView?.collectionViewLayout = layout
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
        self.collectionView?.reloadData()
        
        
    }
}

class CharacterFavoriteCollectionViewDelegate:NSObject, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/5 - 8,
                          height: collectionView.frame.size.width/5 - 8)
        
    }
}

