//
//  CharacterTableViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - View Attributes
    @IBOutlet weak var descriptionCharacter: UILabel!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var addFavoritePressed: (() -> Void)? = nil
    
}

extension CharacterTableViewCell{
    
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK: CharacterTableViewCell methods
    //MARK:-
    ////////////////////////////////////////////////////////////////

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(char: Character){
        self.nameCharacter.text = char.name
        self.descriptionCharacter.text = char.description.isEmpty ? "No description" : char.description
        
        let thumbnail = char.thumbnail!
        
        let urlstr = thumbnail.fullPath()
        
        self.imageCharacter.downloadedFrom(link: urlstr)
    }
}

extension CharacterTableViewCell{
    
    // MARK: - IBActions
    
    @IBAction func didPressFavorite(_ sender: Any) {
        if let addFavoritePressed = self.addFavoritePressed{
            addFavoritePressed()
        }
    }
   
}
