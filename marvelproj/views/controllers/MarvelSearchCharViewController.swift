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
    
    var collectionViewDatasource: CharacterCollectionViewDataSource?
    var characterCollectionViewDelegate: CharacterCollectionViewDelegate?
    
    var searchedCharacters: NSMutableArray!
    var searchActive : Bool = false
    var searchText: String = ""
}

extension MarvelSearchCharViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.isHidden = true
        self.initialSearchScreen.isHidden = false
        self.searchBar.delegate = self
        self.searchedCharacters = NSMutableArray()
    }
    
    func setupCollectionView(){
        
        self.collectionView.isHidden = false
        self.initialSearchScreen.isHidden = true
        self.characterCollectionViewDelegate = CharacterCollectionViewDelegate(self)
        
        self.collectionViewDatasource = CharacterCollectionViewDataSource(collectionView: self.collectionView, delegate: self.characterCollectionViewDelegate!, characters: self.searchedCharacters)
    }
    
}

extension MarvelSearchCharViewController{
    
    func fetchSearchCharacter(nameStartsWith: String){
        MarvelCharInteractor().fetchSearchByNameStartsWith(nameStartsWith: nameStartsWith) { (characters, error) in
            self.searchedCharacters.removeAllObjects()
            self.searchedCharacters.addObjects(from: characters)
            self.setupCollectionView()
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        searchBar.resignFirstResponder()
        
        self.fetchSearchCharacter(nameStartsWith: self.searchText)
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension MarvelSearchCharViewController: MarvelCharacterDelegate{
    
}

