//
//  CoreDataManager.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import CoreData
import Foundation

enum CoreDataFetchResult {
    case success([File])
    case failure(Error)
}

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var mainManagedContext: NSManagedObjectContext = {
        return self.peristentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OktoIDE")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error {
                // TODO - Add production ready error handling
                print("Error Occured while loading stores")
            }
        })
        
        return container
    }()
    

    /// Caches a 'File' object on the SQLite Database
    mutating func save(){
        
        if self.mainManagedContext.hasChanges {
            
            do {
                try mainManagedContext.save()
            } catch {
                let savingErrror = error
                print("Error with description : \(savingErrror.localizedDescription)")
            }
        }
    }
    
    /// Creates and returns a new 'File' object compatible to be stored in SQLite Database
    mutating func create() -> File{
        
        let newFileObject = NSEntityDescription.insertNewObject(forEntityName: "File", into: mainManagedContext) as! File
        return newFileObject
    }
    
    /// Reads and returns all 'File' objects from the SQLite Database
    mutating func fetch(completion: @escaping(CoreDataFetchResult) -> ()) {
        
        do {
            let fetchedFiles = try mainManagedContext.fetch(File.fetchRequest())
            completion(.success(fetchedFiles))
        } catch {
            
        }
    }
    
    /// Removes a 'File' object from the SQLite Database
    static func delete(file: File){
        
        
    }
    
    
    /// Removes a collection  of 'File' object from the SQLite Database
    static func deleteMany(files: [File], completion: (Result<Bool, Error>) -> ()) {
        
        files.forEach { (file) in
            self.delete(file: file)
        }
    }
}
