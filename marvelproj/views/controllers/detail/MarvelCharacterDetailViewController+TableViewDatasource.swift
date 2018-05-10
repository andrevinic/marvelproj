//
//  MarvelCharacterDetailViewController+TableViewDatasource.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation
import UIKit

extension MarvelCharacterDetailViewController:UITableViewDataSource{
    //MARK: UITableViewDataSource
    // MARK: - Vai aumentar aqui cada celula
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 4 && self.stories != nil){
            return (self.stories?.count)!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewHeaderCellTableViewCell.className, for:indexPath) as! MarvelDetailTableViewHeaderCellTableViewCell
            configureHeaderCell(cell: cell)
            return cell
        }
        else if(indexPath.section == 1 && self.comics != nil){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
            //            configureCellComics(cell: cell, forRowAt: indexPath, comics: self.comics!)
            return cell
        }
            
        else if(indexPath.section == 2 && self.series != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
            //            configureCellSeries(cell: cell, forRowAt: indexPath, comics: self.comics!)
            return cell
        }
        
        else if(indexPath.section == 3 && self.events != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
            return cell
        }
        else if(indexPath.section == 4 && self.stories != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailStoriesTableViewCell.className, for: indexPath) as!
            MarvelDetailStoriesTableViewCell
            configureStoryCell(cell: cell, indexPath: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func configureStoryCell(cell: MarvelDetailStoriesTableViewCell, indexPath: IndexPath){
        if let story = self.stories?[indexPath.row]{
            cell.storyDescription.text = story.description
            cell.storyTitle.text = story.title
        }
    }
    
    func configureHeaderCell(cell: MarvelDetailTableViewHeaderCellTableViewCell){
        cell.characterName.text = self.character?.name
        let path = self.character?.thumbnail?.fullPath()
        let url = URL(string: path!)
        cell.characterImage.downloadedFrom(url: url!)
        cell.characterDescription.text = self.character?.description
    }
    
}

extension MarvelCharacterDetailViewController:UITableViewDelegate{
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(indexPath.section == 4){
//            return CGFloat(20)
//        }
//
//        return CGFloat(170)
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return CGFloat(50)
    }
    
    //    func tableviewtitle
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 1:
            return "Comics"
        case 2:
            return "Series"
        case 3:
            return "Events"
        case 4:
            return "Stories"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: tableView.frame)
        headerView.backgroundColor = UIColor.marvel
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 20, width:
            tableView.frame.size.width, height: tableView.frame.size.height))
        headerLabel.font = UIFont(name: "CircularSTD-Black", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(indexPath.section == 4){
            return CGFloat(120)
        }
        
        return CGFloat(250)
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(250)
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1 && self.comics != nil){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        if(indexPath.section == 2 && self.series != nil){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        if(indexPath.section == 3 && self.events != nil){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        
    }
}
