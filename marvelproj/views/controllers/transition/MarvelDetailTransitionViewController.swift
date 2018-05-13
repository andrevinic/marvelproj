//
//  MarvelDetailTransitionViewController.swift
//  marvelproj
//
//  Created by Andre Nogueira on 11/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelDetailTransitionViewController: UIViewController {
    
    @IBOutlet weak var loadingImageView: UIImageView!
    
    var character: Character?
    var comics: [Comics] = []
    var series: [Series] = []
    var events: [Events] = []
    var stories: [Story] = []
    
    var isFavorite: Bool?
}

extension MarvelDetailTransitionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildAnimation()

        let group = DispatchGroup()
        
        group.enter()
        MarvelHTTPManager().fetchComics(characterID: character!.id) { [weak self](comics, error) in
            self?.comics = comics
            
            group.leave()
            
        }
        group.enter()
        MarvelHTTPManager().fetchSeries(characterID: character!.id) { [weak self](series, error) in
            self?.series = series
            
            group.leave()
            
        }
        group.enter()
        MarvelHTTPManager().fetchEvents(characterID: character!.id) { [weak self](events, error) in
            self?.events = events
            
            group.leave()
            
        }
        group.enter()
        MarvelHTTPManager().fetchStories(characterID: character!.id) { [weak self](stories, error) in
            self?.stories = stories
            
            group.leave()
            
        }
        group.notify(queue: .main) {
            let nextController = MarvelRouter.instantiateMarvelCharacterDetailViewController()
            nextController.character = self.character
            nextController.stories = self.stories
            nextController.comics = self.comics
            nextController.series = self.series
            nextController.events = self.events
            nextController.isFavorite = self.isFavorite
            self.loadingImageView.stopAnimating()
            self.navigationController?.pushViewController(nextController, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadingImageView.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func buildAnimation(){
        var array: [UIImage] = []
        array.append(#imageLiteral(resourceName: "frame-1"))
        array.append(#imageLiteral(resourceName: "frame-2"))
        array.append(#imageLiteral(resourceName: "frame-3"))
        array.append(#imageLiteral(resourceName: "frame-4"))
        array.append(#imageLiteral(resourceName: "frame-5"))
        array.append(#imageLiteral(resourceName: "frame-6"))
        array.append(#imageLiteral(resourceName: "frame-7"))
        array.append(#imageLiteral(resourceName: "frame-8"))
        array.append(#imageLiteral(resourceName: "frame-9"))
        array.append(#imageLiteral(resourceName: "frame-44"))
        
//        for index in 0...59{
//            array.append(#imageLiteral(resourceName: "5")index)
//        }
        
        self.loadingImageView.contentMode = .scaleToFill
        self.loadingImageView.animationImages = array
        self.loadingImageView.animationDuration = 1.0
        self.loadingImageView.animationRepeatCount = 0
    }
    
}

