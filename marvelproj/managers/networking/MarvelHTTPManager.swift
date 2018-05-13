//
//  MarvelHTTPManager.swift
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit

class MarvelHTTPManager: NSObject {
    
    func parseToComics(jsonWithObjectRoot: [String: Any])->[Comics]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var comics = [Comics]()
        for item in results{
            if let comic = Comics(json: item){
                comics.append(comic)
            }
        }
        return comics
    }
    
    func parseToSeries(jsonWithObjectRoot: [String: Any])->[Series]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var series = [Series]()
        for item in results{
            if let serie = Series(json: item){
                series.append(serie)
            }
        }
        return series
    }
    
    func parseToEvents(jsonWithObjectRoot: [String: Any])->[Events]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var events = [Events]()
        for item in results{
            if let event = Events(json: item){
                events.append(event)
            }
        }
        return events
    }
    func parseToStories(jsonWithObjectRoot: [String: Any])->[Story]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var stories = [Story]()
        for item in results{
            if let story = Story(json: item){
                stories.append(story)
            }
        }
        return stories
    }


    func parseToCharacters(jsonWithObjectRoot: [String: Any])->[Character]{
        let results = self.removeWrappers(jsonWithObjectRoot: jsonWithObjectRoot)
        var characters = [Character]()
        for item in results{
            if let char = Character(json: item){
                characters.append(char)
            }
        }
        return characters
    }
    
    func removeWrappers(jsonWithObjectRoot: [String:Any])->[[String:Any]]{
        if let datadictionary = try? jsonWithObjectRoot["data"] as! [String: Any]{
            let results = datadictionary["results"] as? [[String: Any]]
            return results!
        }
        return [jsonWithObjectRoot]
        
    }
}

