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
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        collectionView.register(UINib(nibName:MarvelDetailCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: MarvelDetailCollectionViewCell.className)
        
        collectionView.backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            
            self.collectionView.reloadData()
        }
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: D, forSection section: Int){
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
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



