//
//  MarvelCharacterDetailPopupViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 13/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelCharacterDetailPopupViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var titleDetail: UILabel!
    var thumbnail: String?
    var details: Details?
    

    @IBOutlet weak var descriptionDetail: UITextView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.clear
        self.modalPresentationStyle = .popover
        self.view.backgroundColor = UIColor.clear

        self.titleDetail.text = details?.title ?? "No title"
        self.descriptionDetail.text = details?.description ?? "No description"
        if let thumbnail = self.details?.thumbnail {
            let fullPath = thumbnail.fullPath()
            self.detailImage.downloadedFrom(link: fullPath)
        }
        
    }
}
