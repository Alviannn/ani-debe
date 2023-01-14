//
//  Favorite+CoreDataProperties.swift
//  AniDebe
//
//  Created by prk on 1/13/23.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var malId: Int32

}

extension Favorite : Identifiable {

}
