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
        return NUMBER_OF_TABLEVIEW_SECTIONS
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        ////////////////////////////////////////////////////////////////
        //MARK:-
        //MARK:ajustar para quantidade nao zeros = soma count + comics count + series count..
        //MARK:-
        ////////////////////////////////////////////////////////////////

        if(section == 4 && self.stories.count > 0){
            return LIMIT_OF_TABLE_VIEW_CELLS_STORIES
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewHeaderCellTableViewCell.className, for:indexPath) as! MarvelDetailTableViewHeaderCellTableViewCell
            configureHeaderCell(cell: cell)
            return cell
        }
        else if(indexPath.section == 1){
            if(self.comics.count > 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
            return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: MarvelComicsNotFoundTableViewCell.className, for: indexPath)
                return cell
            }
        }
            
        else if(indexPath.section == 2){
            if(self.series.count > 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: MarvelSeriesNotFoundTableViewCell.className, for: indexPath)
                return cell
            }
        }
        
        else if(indexPath.section == 3 ){
            if(self.events.count > 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: MarvelEventsNotFoundTableViewCell.className, for: indexPath)
                return cell
            }
        }
        else if(indexPath.section == 4){
            if(self.stories.count > 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailStoriesTableViewCell.className, for: indexPath) as!
            MarvelDetailStoriesTableViewCell
            configureStoryCell(cell: cell, indexPath: indexPath)
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: MarvelStoriesNotFoundTableViewCell.className, for: indexPath)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func configureStoryCell(cell: MarvelDetailStoriesTableViewCell, indexPath: IndexPath){
//        if(self.stories?.count == 0 || indexPath.row >= (self.stories?.count)!){return}
        let story = self.stories[indexPath.row]
            cell.storyDescription.text = story.description
            cell.storyTitle.text = story.title
        
    }
    
    func configureHeaderCell(cell: MarvelDetailTableViewHeaderCellTableViewCell){
        cell.characterName.text = self.character?.name
        let path = self.character?.thumbnail?.fullPath()
        let url = URL(string: path!)
        cell.characterImage.downloadedFrom(url: url!)
        cell.characterImage.setCircularImageView()
        cell.characterDescription.text = self.character?.description
    }
    
}

extension MarvelCharacterDetailViewController:UITableViewDelegate{
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return CGFloat(HEIGHT_FOR_HEADER_IN_SECTION)
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
        headerLabel.font = UIFont(name: FONT_CIRCULAR_FOR_SECTION, size: CGFloat(SIZE_FOR_HEADER_VIEW_SECTION))
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(indexPath.section == 4){
            return CGFloat(HEIGHT_FOR_TABLE_VIEW_DETAIL_CELL)
        }
        if(indexPath.section == 1 && self.comics.count == 0){
            return CGFloat(50)
        }
        if(indexPath.section == 2 && self.series.count == 0){
            return CGFloat(50)
        }
        if(indexPath.section == 3 && self.events.count == 0){
            return CGFloat(50)
        }
        if(indexPath.section == 4 && self.stories.count == 0){
            return CGFloat(50)
        }
        return CGFloat(HEIGHT_FOR_COLLECTION_VIEW_DETAIL_CELL)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1 && self.comics.count > 0){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        if(indexPath.section == 2 && self.series.count > 0){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        if(indexPath.section == 3 && self.events.count > 0){
            guard let tableViewCell = cell as? MarvelDetailTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forSection: indexPath.section)
        }
        
        
    }
}
