//
//  MarvelCharDetailViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

protocol MarvelCharDetailDelegate: UICollectionViewDelegate{
    func didSelectCharacter(index: IndexPath)
    
}

class MarvelCharDetailViewController: UIViewController {
    
    @IBOutlet var characterDetailView: CharacterDetailView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var characterDetail: UIView!
    @IBOutlet weak var storiesView: StoriesView!
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    var comicsCollectionViewDelegate: ComicsCollectionViewDelegate?
    var comicsCollectionViewDatasource: ComicsCollectionViewDataSource?
    
    var character: Character?
    var stories: [Story] = []
    var comics: [Comics] = []
    
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    
    
}

extension MarvelCharDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.setupView()
        self.setupSwipe()
        self.fetchStories()
        self.fetchComics()
    }
    
    func setupView(){
        self.characterDetailView.setupView(character: self.character!)
    }
    
    func setupCollectionView(){
        
        let comicsArray = NSMutableArray(array: comics)
        self.comicsCollectionViewDelegate = ComicsCollectionViewDelegate()
        self.comicsCollectionViewDatasource = ComicsCollectionViewDataSource(collectionView: self.comicsCollectionView, delegate: comicsCollectionViewDelegate!, array: comicsArray, nibName: "ComicsCollectionViewCell")
        
    }
    
    
}

extension MarvelCharDetailViewController{
    
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage < 1 {
            self.characterDetail.isHidden = true
            self.storiesView.isHidden = false
            self.pageControl.currentPage = self.pageControl.currentPage + 1
        }
        
    }
    
    @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage != 0 {
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            self.characterDetail.isHidden = false
            self.storiesView.isHidden = true
        }
    }
}

extension MarvelCharDetailViewController{
    
    func setupSwipe(){
        self.storiesView.isHidden = true
        self.swipeGestureLeft.addTarget(self, action: #selector(self.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(self.handleSwipeRight(_:)))
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.characterDetailView.addGestureRecognizer(self.swipeGestureLeft)
        self.characterDetailView.addGestureRecognizer(self.swipeGestureRight)
    }
    
    func setupStoriesView(){
        let storiesString = self.createStoriesString()
        self.storiesView.setupStories(stories: storiesString)
    }
    
    func createStoriesString()->String{
        var storiesStr = ""
        var i: Int = 0
        for story in self.stories{
            storiesStr = story.title! + ", " + storiesStr
            i = i + 1
            if( i == 5){
                break
            }
        }
        storiesStr = storiesStr + "..."
        return storiesStr
    }
}

extension MarvelCharDetailViewController{
    func fetchStories(){
        let character = self.character!
        let stories = character.stories!
        MarvelCharInteractor().fetchStories(storiesURL: stories.securePath()) { (stories, error) in
            self.stories = stories
            self.setupStoriesView()
        }
    }
    
    func fetchComics(){
        let character = self.character!
        let comics = character.comics!
        MarvelCharInteractor().fetchComics(comicsURL: comics.securePath()) { (comics, error) in
            self.comics = comics
            self.setupCollectionView()
        }
        
    }
}
extension MarvelCharDetailViewController: MarvelCharDetailDelegate{
    func didSelectCharacter(index: IndexPath) {
        
    }
}

