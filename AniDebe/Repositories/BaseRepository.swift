//
//  BaseRepository.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//

import Foundation
import CoreData
import UIKit

class BaseRepository<T: NSManagedObject> {
    
    let context: NSManagedObjectContext
    let entityName: String
    
    init(entityName: String) {
        self.entityName = entityName
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func create() -> T {
        return T(context: context)
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save an entity: \(error)")
        }
    }
    
    func getAll() -> [T] {
        let request = T.fetchRequest()
        
        do {
            return try context.fetch(request) as! [T]
        } catch {
            print("Failed to fetch entities: \(error)")
        }
        
        return []
    }
    
    func delete(entity: T) {
        context.delete(entity)
        do {
            try context.save()
        } catch {
            print("Failed to delete entity: \(error)")
        }
    }
    
}
