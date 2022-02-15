//
//  Transaction+CoreDataProperties.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 7.02.22.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var date: Date
    @NSManaged public var isOutcome: Bool
    @NSManaged public var note: String?
    @NSManaged public var sum: NSDecimalNumber
    @NSManaged public var title: String
    @NSManaged public var type: TransactionType
    @NSManaged public var wallet: Wallet?

}

extension Transaction : Identifiable {

}
