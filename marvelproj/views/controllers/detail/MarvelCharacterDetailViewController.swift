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
    
    var shownIndexes : [IndexPath] = []
}

extension MarvelCharacterDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
//       self.tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
            self.tableView.register(UINib(nibName:MarvelDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailTableViewCell.className)
//        self.tableView.register(MarvelDetailTableViewCell.self, forCellReuseIdentifier: MarvelDetailTableViewCell.className)
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetailTableViewCell.className, for: indexPath)
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
    }
}

extension MarvelCharacterDetailViewController:UITableViewDelegate{
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Comics"
        case 1:
            return "Series"
        case 2:
            return "Events"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        
        let headerLabel = UILabel(frame: CGRect(x: tableView.bounds.size.width / 3, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
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
