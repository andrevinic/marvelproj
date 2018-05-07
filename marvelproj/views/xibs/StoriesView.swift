//
//  StoriesView.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class StoriesView: UIView {

  @IBOutlet weak var stories: UILabel!

    override func awakeFromNib() {
        self.stories.text = "Stories related:"
    }
    
    func setupStories(stories: String){
        self.stories.text = stories
    }
}
