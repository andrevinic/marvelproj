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
}

extension MarvelCharacterDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = false

        self.tableView.register(UINib(nibName:MarvelDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailTableViewCell.className)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        self.tableView.register(UINib(nibName: MarvelComicsNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelComicsNotFoundTableViewCell.className)
          self.tableView.register(UINib(nibName: MarvelSeriesNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelSeriesNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName: MarvelEventsNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelEventsNotFoundTableViewCell.className)
         self.tableView.register(UINib(nibName: MarvelStoriesNotFoundTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelStoriesNotFoundTableViewCell.className)
        self.tableView.register(UINib(nibName:MarvelDetailTableViewHeaderCellTableViewCell.className, bundle:nil), forCellReuseIdentifier: MarvelDetailTableViewHeaderCellTableViewCell.className)
        self.tableView.register(UINib(nibName:MarvelDetailStoriesTableViewCell.className, bundle: nil), forCellReuseIdentifier: MarvelDetailStoriesTableViewCell.className)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(performSegueToReturnBack))

        self.tableView.reloadData()

    }
}

extension MarvelCharacterDetailViewController{
    func performSegueToReturnBack(){
        if let nav = self.navigationController{
            nav.popToRootViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
}

