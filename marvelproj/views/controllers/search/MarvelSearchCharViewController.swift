//
//  MarvelSearchCharViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 05/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelSearchCharViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var initialSearchScreen: UIView!
    
    @IBOutlet weak var NoFoundSearch: UIView!
    
    var collectionViewDatasource: CharacterCollectionViewDataSource?
    var characterCollectionViewDelegate: CharacterCollectionViewDelegate?
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    var searchedCharacters: NSMutableArray!
    var searchActive : Bool = false
    var searchText: String = ""
    
    var coreDataManager: CoreDataManager!
    var favoriteCharactersIDs:[Int] = []
    var favoriteCharactersFetched:NSMutableArray!
}

extension MarvelSearchCharViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteCharactersFetched = NSMutableArray()
        self.NoFoundSearch.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.isHidden = true
        self.initialSearchScreen.isHidden = false
        self.searchBar.delegate = self
        self.searchedCharacters = NSMutableArray()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    func setupCollectionView(){
        self.loadingActivity.stopAnimating()
        self.NoFoundSearch.isHidden = true
        self.characterCollectionViewDelegate = CharacterCollectionViewDelegate(self, characters: self.searchedCharacters, numberOfCellsInRow: NUMBER_OF_CELLS_IN_COLLECTION_VIEW_IN_SEARCH_CHARACTERS)
        
        self.collectionViewDatasource = CharacterCollectionViewDataSource(collectionView: self.collectionView, delegate: self.characterCollectionViewDelegate!, array: self.searchedCharacters, nibName:CharacterCollectionViewCell.className, favoriteChars: NSMutableArray())
       
            self.collectionView.isHidden = false
            self.initialSearchScreen.isHidden = true
            self.collectionView.reloadInputViews()
            self.collectionView.reloadData()
        
    }
    
}

extension MarvelSearchCharViewController{
    
    func fetchSearchCharacter(nameStartsWith: String){
        self.loadingActivity.startAnimating()
        MarvelHTTPManager().fetchSearchByNameStartsWith(nameStartsWith: nameStartsWith) { (characters, error) in
            if(characters.count == 0){
                
                self.NoFoundSearch.isHidden = false
                self.loadingActivity.stopAnimating()
                self.initialSearchScreen.isHidden = true
                
                
            }else{
            self.searchedCharacters.removeAllObjects()
            self.searchedCharacters.addObjects(from: characters)
           
            DispatchQueue.main.async {
                self.setupCollectionView()
                }
                
            }
        }

    }
    
}
extension MarvelSearchCharViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        searchBar.resignFirstResponder()
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.initialSearchScreen.isHidden = false
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        searchBar.resignFirstResponder()
        
        if(self.searchText.count == 0){return}
        if(self.searchText.trimmingCharacters(in: .whitespacesAndNewlines).count == 0){return}
        self.fetchSearchCharacter(nameStartsWith: self.searchText)
        searchActive = false;
    }
    
}

extension MarvelSearchCharViewController: MarvelCharacterDelegate{
    
    func didSelectCharacter(index: IndexPath) {
        let nextController = MarvelRouter.instantiateMarvelDetailTransitionViewController()
        nextController.character = searchedCharacters.object(at: index.row) as? Character
        self.navigationController?.pushViewController(nextController, animated: true)
        
    }
    func didSelectCharacterFavorite(index: IndexPath) {}

    func fetchCharacters() {}
    
}

extension MarvelSearchCharViewController: MarvelFavorite{
    
    func fetchFavoriteRequestsFromCoreData(){
        let fetchRequests = coreDataManager.fetchRequest()
        for record in fetchRequests{
            if let record_id = record.value(forKey: "characterID") as? Int{
                self.favoriteCharactersIDs.append(record_id)
            }
        }
    }
    
    func fetchCharacterByIDs(){
        let group = DispatchGroup()
        
        for charID in self.favoriteCharactersIDs{
            group.enter()
            MarvelHTTPManager().fetchCharacterByID(characterID: charID) { [weak self] (character, error) in
                self?.favoriteCharactersFetched.add(character)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
//            self.setupFavoriteCollectionView()
        }
    }
    
    func addToFavorite(at indexPath: IndexPath, character: Character){
        
        coreDataManager.addFavorite(character: character)
       
        self.favoriteCharactersFetched.insert(character, at: 0)
        self.favoriteCharactersIDs.append(character.id)
//        self.setupFavoriteCollectionView()
        
    }
    
    func check(charID: Int)->Bool{
        for item in self.favoriteCharactersIDs{
            if item == charID{
                return true
            }
            
        }
        return false
    }
    
}

