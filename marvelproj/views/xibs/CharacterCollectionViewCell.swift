//
//  CharacterCollectionViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameCharacter: UILabel!
    
    @IBOutlet weak var imageCharacter: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(char: Character){
        self.nameCharacter.text = char.name
    
        let thumbnail = char.thumbnail!
        
        let urlstr = thumbnail.fullPath()
//        self.imageCharacter.download(url: urlstr)
        self.imageCharacter.downloadedFrom(url: URL(string: urlstr)!)
    }

}
