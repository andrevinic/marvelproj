//
//  AppDelegate.swift
//  marvelproj
//
//  Created by Andre Nogueira on 04/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        
//        let coreDataManager = CoreDataManager(modelName: "Favorite")
////        print(coreDataManager.managedObjectContext)
//        
//        let managedObjectContext = coreDataManager.managedObjectContext
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Character", in: managedObjectContext)
//        
//        if let entityDescription = entityDescription{
//            print(entityDescription.name ?? "No name")
//            print(entityDescription.properties)
//            
//            let character = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
//            print(character)
//            character.setValue(2, forKey: "characterID")
//            
//            do{
//                try managedObjectContext.save()
//            }catch{
//                
//            }
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
//
//            do{
//                let records = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
//                for record in records{
//                    print(record.value(forKey: "characterID") ?? "no id")
//                }
//            }catch{
//                print(error)
//            }
//        }
        return true
    }

}

