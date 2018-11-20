//
//  History+CoreDataProperties.swift
//  uome
//
//  Created by George Hajjar on 2018-11-17.
//  Copyright © 2018 George Hajjar. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var owed: Array<Double>
    @NSManaged public var participants: Array<String>
    @NSManaged public var title: String?

}
