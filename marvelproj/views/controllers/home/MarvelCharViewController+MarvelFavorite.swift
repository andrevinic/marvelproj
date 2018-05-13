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
                
                if(self.favoriteCharactersIDs.contains(record_id)){
                    
                }
                self.favoriteCharactersIDs.append(record_id)
                
            }
        }
    }
    
    func fetchCharacterByIDs(){
        let group = DispatchGroup()
        
        if(self.favoriteCharactersIDs.count == 0){
            self.favoriteCollectionView.isHidden = true
            self.tableViewTopConstraint.constant = -self.favoriteCollectionViewHeight.constant
            self.collectionViewTopConstraint.constant = -self.favoriteCollectionViewHeight.constant
        }
        for charID in self.favoriteCharactersIDs{
            group.enter()
            MarvelHTTPManager().fetchCharacterByID(characterID: charID) { [weak self] (character, error) in
                self?.favoriteCharactersFetched.add(character)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.setupFavoriteCollectionView()
        }
    }
    
    func addToFavorite(at indexPath: IndexPath, character: Character){
        
        coreDataManager.addFavorite(character: character)
        if(self.favoriteCharactersIDs.count == 0){
            self.favoriteCollectionView.isHidden = false
            self.tableViewTopConstraint.constant = CGFloat(0)
            self.collectionViewTopConstraint.constant = CGFloat(0)
        }
        self.favoriteCharactersFetched.insert(character, at: 0)
        self.favoriteCharactersIDs.append(character.id)
        self.setupFavoriteCollectionView()
        self.setupTableView()
        
    }
    
    func check(charID: Int)->Bool{
        for item in self.favoriteCharactersIDs{
            if item == charID{
                return true
            }
            
        }
        return false
    }
}
