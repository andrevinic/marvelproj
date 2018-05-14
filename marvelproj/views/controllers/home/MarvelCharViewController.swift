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
    func didSelectCharacterFavorite(index: IndexPath)
}
protocol MarvelFavorite{
    func addToFavorite(at indexPath: IndexPath, character: Character)
    func fetchFavoriteRequestsFromCoreData()
    func fetchCharacterByIDs()
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
    
    var characters: [Character] = []
    var offset : Int = 0
    var showDataWithList = true
    
    var coreDataManager: CoreDataManager!
    var favoriteCharactersIDs:[Int] = []
    var favoriteCharactersFetched:[Character] = []
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var favoriteCollectionViewHeight: NSLayoutConstraint!
}

extension MarvelCharViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coreDataManager = CoreDataManager(modelName: "Favorite")
        self.characters = []
        self.favoriteCharactersFetched = []
        self.tableView.isHidden = true
        self.collectionView.isHidden = true
        self.activityIndicator.startAnimating()
        
        self.hideFavoriteBar()
        self.fetchCharacters()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        self.fetchFavoriteRequestsFromCoreData()
        self.fetchCharacterByIDs()
        
        if(self.showDataWithList){
            self.setupTableView()
        }else{
            self.setupCollectionView()
        }
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

        self.characterCollectionViewDelegate = CharacterCollectionViewDelegate(self, characters: self.characters, numberOfCellsInRow: NUMBER_OF_CELLS_IN_COLLECTION_VIEW_IN_CHARACTERS)

        self.collectionViewDatasource = CharacterCollectionViewDataSource(collectionView: self.collectionView, delegate: characterCollectionViewDelegate!, array: self.characters, nibName: CharacterCollectionViewCell.className)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func setupFavoriteCollectionView(){
        self.favoriteCollectionViewDelegate = CharacterFavoriteCollectionViewDelegate(delegate: self)
        self.favoriteCollectionViewDatasource = CharacterFavoriteCollectionViewDataSource(collectionView: self.favoriteCollectionView, delegate: self.favoriteCollectionViewDelegate!, array: self.favoriteCharactersFetched, nibName: MarvelCharFavoriteCollectionViewCell.className)
        if(self.favoriteCharactersFetched.count > 0){
            self.unhideFavoriteBar()
        }
        self.favoriteCollectionView.reloadData()
        
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




