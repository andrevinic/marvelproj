//
//  MarvelCharDetailViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelCharDetailViewController: UIViewController {
    
    @IBOutlet var characterDetailView: CharacterDetailView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var characterDetail: UIView!
    @IBOutlet weak var storiesView: UIView!
    
    var character: Character?
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
}

extension MarvelCharDetailViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.setupView()
        self.storiesView.isHidden = true
        self.swipeGestureLeft.addTarget(self, action: #selector(self.handleSwipeLeft(_:)))
        self.swipeGestureRight.addTarget(self, action: #selector(self.handleSwipeRight(_:)))
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
        self.characterDetailView.addGestureRecognizer(self.swipeGestureLeft)
        self.characterDetailView.addGestureRecognizer(self.swipeGestureRight)
    }
    
    func setupView(){
        self.characterDetailView.setupView(character: self.character!)
    }

}

extension MarvelCharDetailViewController{
    // increase page number on swift left
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage < 1 {
//            self.currentPageNumber += 1
            self.characterDetail.isHidden = true
            self.storiesView.isHidden = false
             self.pageControl.currentPage = self.pageControl.currentPage + 1
        }
       
    }
    
    // reduce page number on swift right
    @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer){
        if  self.pageControl.currentPage != 0 {
            //            self.currentPageNumber += 1
//            self.currentPage.isHidden = true
            self.pageControl.currentPage = self.pageControl.currentPage - 1
            self.characterDetail.isHidden = false
            self.storiesView.isHidden = true
        }
    }
}
