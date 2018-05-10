//
//  MarvelDetailTableViewCell.swift
//  marvelproj
//
//  Created by Andre Nogueira on 08/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit


////////////////////////////////////////////////////////////////
//MARK:- index 1
//MARK:Table view cell with collection
//MARK:-
////////////////////////////////////////////////////////////////

class MarvelDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var comics: [Comics] = []
    var series: [Series] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName:MarvelDetailCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: MarvelDetailCollectionViewCell.className)
        
        collectionView.backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
        }
    }
}

extension MarvelDetailTableViewCell{
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension MarvelDetailTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 100 * 3
        let totalSpacingWidth = 10 * (3 - 1)
        
        let leftInset = (self.collectionView.bounds.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO:- Required Method
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelDetailCollectionViewCell.className, for: indexPath) as! MarvelDetailCollectionViewCell
        if(self.comics.count > 0){
            configureCell(cell: cell, forItemAt: indexPath)
        }
        // TODO:- Required Method
        return cell
    }
    
    func configureCell(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {
        //        let image = UIImage(named: "marvel_screen")
        //       cell.collectionCellImage = UIImageView(image: image)
        
        let comic = self.comics[indexPath.row]
        let img_url = (comic.thumbnail?.fullPath())!
        let url = URL(string: img_url)!
        cell.collectionCellImage.downloadedFrom(url: url)
        cell.detailName.text = comic.title!
    }
    
}

