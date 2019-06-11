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
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OktoIDE")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if (error != nil) {
                // TODO - Add production ready error handling
                print("Error Occured while loading stores")
            }
        })
        
        return container
    }()
    
    /// Caches a 'File' object on the SQLite Database
    func save(){
        
        if (self.persistentContainer.viewContext.hasChanges) {
            
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                let savingErrror = error
                print("Error with description : \(savingErrror.localizedDescription)")
            }
        }
    }
    
    /// Creates and returns a new 'File' object compatible to be stored in SQLite Database
    func create() -> File{
        
        let newFileObject = NSEntityDescription.insertNewObject(forEntityName: "File", into: persistentContainer.viewContext) as! File
        return newFileObject
    }
    
    /// Reads and returns all 'File' objects from the SQLite Database
    func fetchTrips(completion: @escaping(CoreDataFetchResult) -> ()) {
        
        let fetchRequest: NSFetchRequest<File> = File.fetchRequest()
        let viewContext = persistentContainer.viewContext
        
        do {
            let allTrips = try viewContext.fetch(fetchRequest)
            completion(.success(allTrips))
        } catch {
            completion(.failure(error))
        }
    }
    
    /// Removes a 'File' object from the SQLite Database and saves the changes
    func delete(file: File){
        
        self.persistentContainer.viewContext.delete(file)
        self.save()
    }
    
    
    /// Removes a collection  of 'File' object from the SQLite Database
    func deleteMany(files: [File], completion: (Result<Bool, Error>) -> ()) {
        
        files.forEach { (file) in
            self.delete(file: file)
        }
    }
}
