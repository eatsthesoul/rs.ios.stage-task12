//
//  Wallet+CoreDataProperties.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 12.01.22.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var colorTheme: Int32
    @NSManaged public var currencyCode: String?
    @NSManaged public var title: String?
    @NSManaged public var transactionsRelationship: NSOrderedSet?

}

// MARK: Generated accessors for transactionsRelationship
extension Wallet {

    @objc(insertObject:inTransactionsRelationshipAtIndex:)
    @NSManaged public func insertIntoTransactionsRelationship(_ value: Transaction, at idx: Int)

    @objc(removeObjectFromTransactionsRelationshipAtIndex:)
    @NSManaged public func removeFromTransactionsRelationship(at idx: Int)

    @objc(insertTransactionsRelationship:atIndexes:)
    @NSManaged public func insertIntoTransactionsRelationship(_ values: [Transaction], at indexes: NSIndexSet)

    @objc(removeTransactionsRelationshipAtIndexes:)
    @NSManaged public func removeFromTransactionsRelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsRelationshipAtIndex:withObject:)
    @NSManaged public func replaceTransactionsRelationship(at idx: Int, with value: Transaction)

    @objc(replaceTransactionsRelationshipAtIndexes:withTransactionsRelationship:)
    @NSManaged public func replaceTransactionsRelationship(at indexes: NSIndexSet, with values: [Transaction])

    @objc(addTransactionsRelationshipObject:)
    @NSManaged public func addToTransactionsRelationship(_ value: Transaction)

    @objc(removeTransactionsRelationshipObject:)
    @NSManaged public func removeFromTransactionsRelationship(_ value: Transaction)

    @objc(addTransactionsRelationship:)
    @NSManaged public func addToTransactionsRelationship(_ values: NSOrderedSet)

    @objc(removeTransactionsRelationship:)
    @NSManaged public func removeFromTransactionsRelationship(_ values: NSOrderedSet)

}

extension Wallet : Identifiable {

}
