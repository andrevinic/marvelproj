//
//  MarvelCharViewController+MarvelCharacterDelegate.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

extension MarvelCharViewController: MarvelCharacterDelegate{
    
    func didSelectCharacter(index: IndexPath) {
        
        let nextController = MarvelRouter.instantiateMarvelDetailTransitionViewController()
        let char = characters.object(at: index.row) as? Character
        nextController.character = char
        
        if(self.check(charID: (char?.id)!)){
            nextController.isFavorite = true
        }else{
            nextController.isFavorite = false
        }
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func fetchCharacters(){
        self.activityIndicator.startAnimating()
        
        MarvelHTTPManager().fetchCharacters(offset: self.offset) { (characters, error) in
            self.characters.addObjects(from: characters)
            
            self.offset += LIMIT_FETCH
            if(self.showDataWithList){
                self.setupTableView()
            }else{
                self.setupCollectionView()
            }
        }
        
    }
    
}
