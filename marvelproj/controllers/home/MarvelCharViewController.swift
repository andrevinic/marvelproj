//
//  MarvelCharViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
protocol MarvelCharacterDelegate: UICollectionViewDelegate{
    func fetchCharacters()
    func didSelectCharacter(index: IndexPath)
}

class MarvelCharViewController: UIViewController {
   
    @IBOutlet weak var navigationItemMarvel: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var collectionViewDatasource: CharacterCollectionViewDataSource?
    var favoriteCollectionViewDatasource: CharacterFavoriteCollectionViewDataSource?
    var favoriteCollectionViewDelegate: CharacterFavoriteCollectionViewDelegate?
    var characterCollectionViewDelegate: CharacterCollectionViewDelegate?
    
    var characters: NSMutableArray!
    var offset : Int = 0
    var showDataWithList = true
}

extension MarvelCharViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.characters = NSMutableArray()
        self.tableView.isHidden = true
        self.collectionView.isHidden = true
        self.activityIndicator.startAnimating()
        self.fetchCharacters()
        
    }
    
}
extension MarvelCharViewController{
   
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        self.tableView.register(UINib(nibName:CharacterTableViewCell.className, bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.className)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        self.showDataWithList = true
        
    }
    
    func setupCollectionView(){

        self.collectionView.isHidden = false
        self.tableView.isHidden = true
        self.showDataWithList = false

        self.characterCollectionViewDelegate = CharacterCollectionViewDelegate(self, characters: self.characters!)

        self.collectionViewDatasource = CharacterCollectionViewDataSource(collectionView: self.collectionView, delegate: characterCollectionViewDelegate!, array: self.characters, nibName: CharacterCollectionViewCell.className)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func setupFavoriteCollectionView(){
        self.favoriteCollectionViewDelegate = CharacterFavoriteCollectionViewDelegate()
        self.favoriteCollectionViewDatasource = CharacterFavoriteCollectionViewDataSource(collectionView: self.favoriteCollectionView, delegate: self.favoriteCollectionViewDelegate!, array: self.characters, nibName: MarvelCharFavoriteCollectionViewCell.className)
        DispatchQueue.main.async {

            self.favoriteCollectionView.reloadData()
        }
    }
    
}

extension MarvelCharViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(characters.count == 0){
            return UITableViewCell()
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className, for: indexPath) as! CharacterTableViewCell
        let character = self.characters.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        let selectionColor = UIView(frame: cell.frame)
        selectionColor.backgroundColor = UIColor.black
        cell.selectedBackgroundView = selectionColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters.count) - 1){
            self.fetchCharacters()
   
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didSelectCharacter(index: indexPath)
    }
}


extension MarvelCharViewController{
    
    @IBAction func pressedGrid(_ sender: UIButton){
        self.setupCollectionView()
    }
    
    @IBAction func pressedList(_ sender: UIButton){
        self.setupTableView()
    }
    
}

extension MarvelCharViewController: MarvelCharacterDelegate{
    
    func didSelectCharacter(index: IndexPath) {

        let nextController = MarvelRouter.instantiateMarvelDetailTransitionViewController()
        nextController.character = characters.object(at: index.row) as? Character
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func fetchCharacters(){
        self.activityIndicator.startAnimating()

        MarvelHTTPManager().fetchCharacters(offset: self.offset) { (characters, error) in
            self.characters.addObjects(from: characters)
            self.setupFavoriteCollectionView()
            
            self.offset += LIMIT_FETCH
            if(self.showDataWithList){
                self.setupTableView()
            }else{
                self.setupCollectionView()
            }
        }

    }
}



