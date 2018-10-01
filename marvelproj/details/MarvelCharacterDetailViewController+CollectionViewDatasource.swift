////
////  MarvelCharacterDetailViewController+Datasource.swift
////  marvelproj
////
////  Created by Andre Nogueira on 10/05/18.
////  Copyright © 2018 Andre Nogueira. All rights reserved.
////
//
import Foundation
import UIKit

extension MarvelCharacterDetailViewController:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(collectionView.tag){
        case KindCell.comics.rawValue:
            return self.comics.count
        case KindCell.series.rawValue:
            return self.series.count
        case KindCell.events.rawValue:
            return self.events.count
        case KindCell.stories.rawValue:
            return self.stories.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelDetailCollectionViewCell.className, for: indexPath) as! MarvelDetailCollectionViewCell
        
        if(collectionView.tag == KindCell.comics.rawValue){
            configureComicsCell(cell: cell, indexPath: indexPath)
        }else if(collectionView.tag == KindCell.series.rawValue){
            configureSeriesCell(cell: cell, indexPath: indexPath)
        }else if(collectionView.tag == KindCell.events.rawValue){
            configureEventsCell(cell: cell, indexPath: indexPath)
        }

        return cell
    }

    private func configureEventsCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.events.count == 0){
            return
        }
        configureCellEvent(cell: cell, forItemAt: indexPath)
    }
    private func configureComicsCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.comics.count == 0){
            return
        }
        configureCellComic(cell: cell, forItemAt: indexPath)
    }
    
    private func configureSeriesCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.series.count == 0){
            return
        }
        configureCellSerie(cell: cell, forItemAt: indexPath)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
extension MarvelCharacterDetailViewController:UICollectionViewDelegate{

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details: Details? = self.getDetails(collectionView: collectionView, at: indexPath)

       
        guard let popUpViewController =  R.storyboard.main.marvelCharacterDetailPopupViewController()
            else {return}
        popUpViewController.details = details
        self.navigationController?.pushViewController(popUpViewController, animated: false)
        
    }
    
    func getDetails(collectionView: UICollectionView, at indexPath: IndexPath)->Details{
        switch(collectionView.tag){
            case KindCell.comics.rawValue:
                return self.comics[indexPath.row]
            case KindCell.series.rawValue:
                return self.series[indexPath.row]
            case KindCell.events.rawValue:
                return self.events[indexPath.row]
            
            default:
                return self.comics[indexPath.row]
        }
    }
}
extension MarvelCharacterDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: SIZE_FOR_COLLECTION_VIEW_LAYOUT_WIDTH, height: SIZE_FOR_COLLECTION_VIEW_LAYOUT_HEIGHT)
    }

}

extension MarvelCharacterDetailViewController{
    func configureCellComic(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {

        let comic = self.comics[indexPath.row] as Comics
        guard let img_url = (comic.thumbnail?.fullPath()) else{
            return
        }
        cell.collectionCellImage.download(image: img_url)
        
    }
    func configureCellEvent(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let event = events[indexPath.row] as Events
        guard let img_url = (event.thumbnail?.fullPath()) else{
            return
        }
        cell.collectionCellImage.download(image: img_url)

        
    }
    func configureCellSerie(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {

         let serie = series[indexPath.row] as Series
        if let img_url = (serie.thumbnail?.fullPath()){
            cell.collectionCellImage.download(image: img_url)
        }
        
    }
}


