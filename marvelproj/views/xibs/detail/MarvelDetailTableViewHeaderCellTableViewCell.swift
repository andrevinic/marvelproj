//
//  MarvelDetailTableViewHeaderCellTableViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelDetailTableViewHeaderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    var addFavoritePressed: (() -> Void)? = nil
    
    
}

extension MarvelDetailTableViewHeaderCellTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSwipe()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func setupSwipe(){
        self.swipeGestureLeft.addTarget(self, action: #selector(self.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(self.handleSwipeRight(_:)))
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.addGestureRecognizer(self.swipeGestureLeft)
        self.addGestureRecognizer(self.swipeGestureRight)
    }
}

extension MarvelDetailTableViewHeaderCellTableViewCell{
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage < 1 {
            self.characterImage.isHidden = true
            self.characterDescription.isHidden = false
            self.characterName.isHidden = true
            self.pageControl.currentPage = self.pageControl.currentPage + 1
        }
        
    }
    
    @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage != 0 {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            self.characterImage.isHidden = false
            self.characterDescription.isHidden = true
            self.characterName.isHidden = false
        }
    }
    
    @IBAction func didPressFavorite(_ sender: Any) {
        if let addFavoritePressed = self.addFavoritePressed{
            addFavoritePressed()
        }
    }
        
    
}
