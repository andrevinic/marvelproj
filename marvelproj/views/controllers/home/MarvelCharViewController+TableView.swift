//
//  MarvelCharViewController+TableView.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import UIKit

extension MarvelCharViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(characters.count == 0){
            return UITableViewCell()
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className, for: indexPath) as! CharacterTableViewCell
        let character = self.characters[indexPath.row]
        cell.setupCell(char: character)
        
        cell.addFavoritePressed = {
            self.addToFavorite(at: indexPath, character: character)
        }
        
       configureCellFavorite(character: character, cell: cell)

        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters.count) - 1){
            self.fetchCharacters()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didSelectCharacter(index: indexPath)
    }
    
    func configureCellFavorite(character: Character, cell: CharacterTableViewCell){
        let charID = character.id
        if self.favoriteCharactersIDs.contains(charID){
            let imageFavoriteSelected = UIImage(named: "favorite_selected")
            cell.favoriteButton.setImage(imageFavoriteSelected, for: .normal)
        }else{
            let imageFavoriteNotSelected = UIImage(named: "favorite_unselected")
            cell.favoriteButton.setImage(imageFavoriteNotSelected, for: .normal)
        }
    }
}
