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
        
// MARK: - Configurar em variavel..
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelDetailCollectionViewCell.className, for: indexPath) as! MarvelDetailCollectionViewCell
        if(collectionView.tag == 1){
            configureComicsCell(cell: cell, indexPath: indexPath)
        }else if(collectionView.tag == 2){
            configureSeriesCell(cell: cell, indexPath: indexPath)
        }else if(collectionView.tag == 3){
            configureEventsCell(cell: cell, indexPath: indexPath)
        }

        return cell
    }

    private func configureEventsCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.events == nil || self.events?.count == 0 || indexPath.row >= (events?.count)!){
            return
        }
        configureCellEvent(cell: cell, forItemAt: indexPath)
    }
    private func configureComicsCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.comics == nil || self.comics?.count == 0 || indexPath.row >= (comics?.count)!){
            return
        }
        configureCellComic(cell: cell, forItemAt: indexPath)
    }
    
    private func configureSeriesCell(cell: MarvelDetailCollectionViewCell, indexPath: IndexPath){
        if(self.series == nil || self.series?.count == 0 || indexPath.row >= (series?.count)!){
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
}
extension MarvelCharacterDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth = 100 * 3
        let totalSpacingWidth = 10 * (3 - 1)

        let leftInset = (collectionView.bounds.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
}

extension MarvelCharacterDetailViewController{
    func configureCellComic(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {

        if let comic = (self.comics?[indexPath.row]) as? Comics{
            let img_url = (comic.thumbnail?.fullPath())!
            let url = URL(string: img_url)!
            cell.collectionCellImage.downloadedFrom(url: url)
            cell.detailName.text = comic.title!
        }
    }
    func configureCellEvent(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {
        if let event = (events?[indexPath.row] as? Events){
            let img_url = (event.thumbnail?.fullPath())!
            let url = URL(string: img_url)!
            cell.collectionCellImage.downloadedFrom(url: url)
            cell.detailName.text = event.title!
        }
    }
    func configureCellSerie(cell: MarvelDetailCollectionViewCell, forItemAt indexPath: IndexPath) {

        if let serie = (series?[indexPath.row]) as? Series{
            let img_url = (serie.thumbnail?.fullPath())!
            let url = URL(string: img_url)!
            cell.collectionCellImage.downloadedFrom(url: url)
            cell.detailName.text = serie.title!
        }
    }
}


