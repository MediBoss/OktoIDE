//
//  CoreDataManager.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import CoreData
import Foundation

//enum CoreDataFetchResult {
//    case success([])
//    case failure(Error)
//}

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
    
    func create() {
        
        
    }
}
