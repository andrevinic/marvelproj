//
//  ComicsCollectionViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comicsImage: UIImageView!
    
    @IBOutlet weak var comicsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupComicsCell(comics: Comics){
//        self.comicsTitle.text = comics.title
        let thumbnail = comics.thumbnail!
        self.comicsImage.download(url: thumbnail.fullPath())
    }

}
