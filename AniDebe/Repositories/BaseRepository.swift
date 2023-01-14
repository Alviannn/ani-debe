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
    
    func save(entity: T) throws {
        try context.save()
    }
    
    func getAll() throws -> [T] {
        let request = T.fetchRequest()
        return try context.fetch(request) as! [T]
    }
    
    func delete(entity: T) throws {
        context.delete(entity)
        try context.save()
    }
    
}
