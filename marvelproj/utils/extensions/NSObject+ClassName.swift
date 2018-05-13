//
//  NSObject+ClassName.swift
//  marvelproj
//
//  Created by Andre Nogueira on 08/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

extension NSObject{
    
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK: NSObject extension
    //MARK:- should return class name to all project objects
    ////////////////////////////////////////////////////////////////

    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
}

