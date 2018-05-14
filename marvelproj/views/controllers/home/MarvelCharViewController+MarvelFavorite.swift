//
//  MarvelCharViewController+MarvelFavorite.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import UIKit

extension MarvelCharViewController:MarvelFavorite{
    func fetchFavoriteRequestsFromCoreData(){
        let fetchRequests = coreDataManager.fetchRequest()
        for record in fetchRequests{
            if let record_id = record.value(forKey: "characterID") as? Int{
                
                if(!self.favoriteCharactersIDs.contains(record_id)){
                    self.favoriteCharactersIDs.append(record_id)
                    
                }
            }
        }
    }
    
    func fetchCharacterByIDs(){
        let group = DispatchGroup()
        
        for charID in self.favoriteCharactersIDs{
            group.enter()
            MarvelHTTPManager().fetchCharacterByID(characterID: charID) { [weak self] (character, error) in
                
                if let contains = (self?.favoriteCharactersFetched.contains(character)){
                    do {
                        if(!contains){
                            self?.favoriteCharactersFetched.append(character)
                        }
                        
                    }
                    
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.setupFavoriteCollectionView()
        }
    }
    
    func addToFavorite(at indexPath: IndexPath, character: Character){
        
        coreDataManager.addFavorite(character: character)
        
        self.favoriteCharactersFetched.insert(character, at: 0)
        self.favoriteCharactersIDs.append(character.id)
        self.setupFavoriteCollectionView()
        self.setupTableView()
        
    }
    
    func hideFavoriteBar(){
        if(self.favoriteCharactersIDs.count == 0){
            self.favoriteCollectionView.isHidden = true
            self.tableViewTopConstraint.constant = -self.favoriteCollectionViewHeight.constant
            self.collectionViewTopConstraint.constant = -self.favoriteCollectionViewHeight.constant
        }
    }
    
    func unhideFavoriteBar(){
        self.favoriteCollectionView.isHidden = false
        self.tableViewTopConstraint.constant = CGFloat(0)
        self.collectionViewTopConstraint.constant = CGFloat(0)
    }
}

