//
//  MarvelCharViewController+MarvelCharacterDelegate.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension MarvelCharViewController: MarvelCharacterDelegate{
    
    func didSelectCharacterFavorite(index: IndexPath){
        
        guard let nextController = R.storyboard.main.marvelDetailTransitionViewController()
            else {return}
        let char = self.favoriteCharactersFetched[index.row]
        nextController.character = char
        nextController.isFavorite = true
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func didSelectCharacter(index: IndexPath) {
        
        guard let nextController = R.storyboard.main.marvelDetailTransitionViewController()
            else {return}

        let char = characters[index.row]
        nextController.character = char
        
        
        if(self.favoriteCharactersIDs.contains(char.id)){
            nextController.isFavorite = true
        }else{
            nextController.isFavorite = false
        }
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func fetchCharacters(){
        self.activityIndicator.startAnimating()
        
        MarvelHTTPManager().fetchCharacters(offset: self.offset) { (characters, error) in
            if let characters = characters {
                self.characters += characters
            }
            self.offset += LIMIT_FETCH
            if(self.showDataWithList){
                self.setupTableView()
            }else{
                self.setupCollectionView()
            }
        }
        
    }
    
}
