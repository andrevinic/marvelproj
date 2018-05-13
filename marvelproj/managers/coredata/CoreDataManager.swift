//
//  CoreDataManager.swift
//  marvelproj
//
//  Created by Andre Nogueira on 12/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataManager {

    // MARK: - properties
    private let modelName: String
    
    // MARK: - initialization
    
    // MARK: - Core Data Stack
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        return managedObjectModel

    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        return persistentStoreCoordinator

    }()
    
    
    init(modelName: String) {
        self.modelName = modelName
    }
}

extension CoreDataManager{
    func addFavorite(character: Character){

        let entityDescription = NSEntityDescription.entity(forEntityName: "Character", in: self.managedObjectContext)
        if let entityDescription = entityDescription{
            let characterToFavorite = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
            characterToFavorite.setValue(character.id, forKey: "characterID")
            do{
                try managedObjectContext.save()
            }catch{
                print(error)

            }
        }
    }
    
    func fetchRequest()->[NSManagedObject]{
        
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Character")
            let records = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            return records
        }catch{
            print(error)
        }
        
        return []
    }
}
