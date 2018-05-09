//
//  CharacterDetailView.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterDetailView: UIView {
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
   
    override func awakeFromNib() {
         self.characterImage.layer.masksToBounds = true
    }
    
    func setupView(character: Character){
        let thumbnail = character.thumbnail
        self.characterName.text = character.name
        let url = URL(string: (thumbnail?.fullPath())!)
        self.characterImage.downloadedFrom(url: url!)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}
