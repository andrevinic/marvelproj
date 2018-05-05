//
//  MarvelCharViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelCharViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UITableView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var characters: NSMutableArray!
    var offset : Int = 0
    var limit: Int = 10
}

extension MarvelCharViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characters = NSMutableArray()
        self.setupTableView()
        self.activityIndicator.startAnimating()
        self.fetchCharacters()
        
    }
    
}
extension MarvelCharViewController{
    func fetchCharacters(){
        MarvelCharInteractor().fetchCharacteres(limit: limit, offset: offset) { (characters, error) in
            self.characters.addObjects(from: characters)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.offset += self.limit
            self.tableView.finishInfiniteScroll()
            self.tableView.isHidden = false
        }
    }
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.tableView.register(UINib(nibName:"CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
    }
}

extension MarvelCharViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(characters.count == 0){
            return 0
        }
        
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(characters.count == 0){
            return UITableViewCell()
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = self.characters.object(at: indexPath.row)
        cell.setupCell(char: character as! Character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters.count) - 1){
            self.tableView.addInfiniteScroll(handler: { (tableView) in
                self.fetchCharacters()
            })
        }
    }
}



