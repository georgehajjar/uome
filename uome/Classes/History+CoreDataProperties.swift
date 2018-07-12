//
//  History+CoreDataProperties.swift
//  uome
//
//  Created by George Hajjar on 2018-07-11.
//  Copyright © 2018 George Hajjar. All rights reserved.
//
//

import Foundation
import CoreData

extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var title: String?
    @NSManaged public var participants: NSSet?

}

// MARK: Generated accessors for participants
extension History {

    @objc(addParticipantsObject:)
    @NSManaged public func addToParticipants(_ value: Person)

    @objc(removeParticipantsObject:)
    @NSManaged public func removeFromParticipants(_ value: Person)

    @objc(addParticipants:)
    @NSManaged public func addToParticipants(_ values: NSSet)

    @objc(removeParticipants:)
    @NSManaged public func removeFromParticipants(_ values: NSSet)

}
