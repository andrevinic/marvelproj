//
//  MarvelCharFavoriteCollectionViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelCharFavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteImageCharacter: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteImageCharacter.layer.masksToBounds = true
    }
    
    func setupCell(char: Character){
        let thumbnail = char.thumbnail!
        let url = URL(string: thumbnail.fullPath())
        self.favoriteImageCharacter.downloadedFrom(url: url!)
        self.favoriteImageCharacter.setCircularImageView()
        self.favoriteImageCharacter.backgroundColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
