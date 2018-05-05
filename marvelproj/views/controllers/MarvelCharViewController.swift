//
//  MarvelCharViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MarvelCharViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var characters: NSMutableArray!
    var offset : Int = 0
    var limit: Int = 10
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
    func fetchCharacters(){
        MarvelCharInteractor().fetchCharacteres(limit: limit, offset: offset) { (characters, error) in
            self.characters.addObjects(from: characters)
            self.tableView.reloadData()
            self.setupFavoriteCollectionView()

            self.activityIndicator.stopAnimating()
            self.offset += self.limit
            //            self.tableView.finishInfiniteScroll()
            if(self.showDataWithList){
                self.setupTableView()
            }else{
                self.setupCollectionView()
            }
        }
    }
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        self.tableView.register(UINib(nibName:"CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        self.tableView.reloadData()
        self.showDataWithList = true
        self.tableView.finishInfiniteScroll()
    }
    
    func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isHidden = false
        self.tableView.isHidden = true
        self.showDataWithList = false
        self.collectionView.register(UINib(nibName:"CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        self.collectionView.reloadData()
        self.collectionView.finishInfiniteScroll()
    }
    
    func setupFavoriteCollectionView(){
        self.favoriteCollectionView.delegate = self
        self.favoriteCollectionView.dataSource = self
        self.favoriteCollectionView.isHidden = false
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ZoomInOutAttributesAnimator()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        self.favoriteCollectionView.collectionViewLayout = layout
        self.favoriteCollectionView.register(UINib(nibName:"MarvelCharFavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MarvelCharFavoriteCollectionViewCell")
        favoriteCollectionView.collectionViewLayout.invalidateLayout()

        self.favoriteCollectionView.reloadData()
        
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = self.characters.object(at: indexPath.row) as! Character
        cell.setupCell(char: character)
        
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

extension MarvelCharViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.favoriteCollectionView){
            if(self.characters.count == 0){
                return UICollectionViewCell()
            }
             let cell = self.favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "MarvelCharFavoriteCollectionViewCell", for: indexPath) as! MarvelCharFavoriteCollectionViewCell
            let character = self.characters.object(at: indexPath.row) as! Character
            cell.setupCell(char: character)
            cell.favoriteImageCharacter.backgroundColor = .lightGray

            return cell
        }else{
            
            if(characters.count == 0){
                return UICollectionViewCell()
            }
            
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
            let character = self.characters.object(at: indexPath.row) as! Character
            cell.setupCell(char: character)
            
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.favoriteCollectionView{
//            return 2
//        }
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == (self.characters.count) - 1){
            self.collectionView.addInfiniteScroll(handler: { (collectionView) in
                self.fetchCharacters()
            })
        }
    }
}

extension MarvelCharViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.collectionView){
            let collectionViewSize = collectionView.frame.size.width
             return CGSize(width: collectionViewSize, height: collectionViewSize)
        }
        
        return CGSize(width: collectionView.frame.size.width/5 - 8,
                      height: collectionView.frame.size.width/5 - 8)
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



