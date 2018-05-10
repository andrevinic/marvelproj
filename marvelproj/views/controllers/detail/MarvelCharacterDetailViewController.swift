//
//  MarvelCharacterDetailViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 08/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelCharacterDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var character: Character?
    var comics: [Comics]?
    var series: [Series]?
}

extension MarvelCharacterDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName:MarvelDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailTableViewCell.className)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
    
        self.tableView.register(UINib(nibName:MarvelDetailTableViewHeaderCellTableViewCell.className, bundle:nil), forCellReuseIdentifier: MarvelDetailTableViewHeaderCellTableViewCell.className)
            MarvelHTTPManager().fetchComics(characterID: character!.id) { (comics, error) in
            self.comics = comics
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        MarvelHTTPManager().fetchSeries(characterID: character!.id) { (series, error) in
            self.series = series
        }
//        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
}

extension MarvelCharacterDetailViewController:UITableViewDataSource{
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            configureCellComics(cell: cell, forRowAt: indexPath, comics: self.comics!)
            return cell
        }
        
        else if(indexPath.section == 2 && self.series != nil){
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath) as! MarvelDetailTableViewCell
            configureCellSeries(cell: cell, forRowAt: indexPath, comics: self.comics!)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func configureHeaderCell(cell: MarvelDetailTableViewHeaderCellTableViewCell){
        cell.characterName.text = self.character?.name
        let path = self.character?.thumbnail?.fullPath()
        let url = URL(string: path!)
        cell.characterImage.downloadedFrom(url: url!)
        cell.characterDescription.text = self.character?.description
    }
    
    func configureCellSeries(cell: MarvelDetailTableViewCell, forRowAt indexPath: IndexPath, comics:[Comics]) {
        cell.series = series!
    }
    func configureCellComics(cell: MarvelDetailTableViewCell, forRowAt indexPath: IndexPath, comics:[Comics]) {
        cell.comics = comics
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if (shownIndexes.contains(indexPath) == false) {
//            shownIndexes.append(indexPath)
//            
//            cell.transform = CGAffineTransform(translationX: 0, y: 120)
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
//            cell.alpha = 0
//            
//            UIView.beginAnimations("rotation", context: nil)
//            UIView.setAnimationDuration(0.5)
//            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            cell.alpha = 1
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            UIView.commitAnimations()
//        }
    }
   
}

class MarvelCharacterDetailViewHeader:UIView{
    
    @IBOutlet weak var marvelCharacterImage: UIImageView!
    @IBOutlet weak var marvelCharacterName: UILabel!
    
    func setupHeader(character: Character){
        self.marvelCharacterName.text = character.name
    }
}
