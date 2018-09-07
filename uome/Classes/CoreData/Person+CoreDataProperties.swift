//
//  Person+CoreDataProperties.swift
//  uome
//
//  Created by George Hajjar on 2018-07-11.
//  Copyright © 2018 George Hajjar. All rights reserved.
//
//

import Foundation
import CoreData

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var money: Double
    @NSManaged public var name: String?

}
