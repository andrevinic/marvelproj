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
    var comics: [Comics] = []
    var series: [Series] = []
    var events: [Events] = []
    var stories: [Story] = []
    
    var coreDataManager: CoreDataManager!
    var isFavorite = false
}

extension MarvelCharacterDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(performSegueToReturnBack))
        
        self.setupTableView()

        self.coreDataManager = CoreDataManager(modelName: "Favorite")
        
        
    }
}

extension MarvelCharacterDetailViewController{
    
    func setupTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //TODO R.swift
        
        self.tableView.register(UINib(nibName:MarvelDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailTableViewCell.className)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.marvelComicsNotFoundTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MarvelComicsNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.marvelSeriesNotFoundTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MarvelSeriesNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName: MarvelEventsNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelEventsNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName: MarvelStoriesNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelStoriesNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName:MarvelDetailTableViewHeaderCellTableViewCell.className, bundle:nil), forCellReuseIdentifier: MarvelDetailTableViewHeaderCellTableViewCell.className)
        self.tableView.register(UINib(nibName:MarvelDetailStoriesTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailStoriesTableViewCell.className)
        
         self.tableView.reloadData()
    }
    @objc func performSegueToReturnBack(){
        if let nav = self.navigationController{
            nav.popToRootViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}


