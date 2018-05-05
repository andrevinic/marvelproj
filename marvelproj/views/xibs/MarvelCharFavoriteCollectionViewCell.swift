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
        self.favoriteImageCharacter.download(url: thumbnail.fullPath())
        self.setCircularImageView()
        self.favoriteImageCharacter.backgroundColor = UIColor.black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setCircularImageView() {
        self.favoriteImageCharacter.layer.cornerRadius = CGFloat(roundf(Float(self.favoriteImageCharacter.frame.size.width / 2.0)))
    }
}
