//
//  MarvelCharacterDetailViewController+MarvelFavorite.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension MarvelCharacterDetailViewController: MarvelFavorite{
    
    func addToFavorite(at indexPath: IndexPath, character: Character) {
        self.coreDataManager.addFavorite(character: character)
        self.isFavorite = true
        self.tableView.reloadData()
        
    }
    
    func fetchFavoriteRequestsFromCoreData() {
        
    }
    
    func fetchCharacterByIDs() {
        
    }
    
    func check(charID: Int) -> Bool {
        if(self.isFavorite){
            return true
        }
        
        return false
    }
    
    
}
