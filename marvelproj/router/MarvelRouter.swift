//
//  MarvelRouter.swift
//  marvelproj
//
//  Created by Andre Nogueira on 06/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelRouter: NSObject {

    class func instantiateMarvelCharDetailViewController() -> MarvelCharDetailViewController{
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MarvelCharDetailViewController")
        return controller as! MarvelCharDetailViewController
    }
}
