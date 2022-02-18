//
//  TransactionType.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 14.02.22.
//

import Foundation
import UIKit

@objc public enum TransactionType: Int32, CaseIterable {
    
    case foodAndDrinks, shopping, transport, payments, entertainment, car, investments, sport, healthcare, education, travel, gifts, salary, other
}

extension TransactionType {
    
    var image: UIImage {
        switch self {
        case .foodAndDrinks:
            return .food
        case .shopping:
            return .shopping
        case .transport:
            return .transport
        case .payments:
            return .payments
        case .entertainment:
            return .entertainment
        case .car:
            return .car
        case .investments:
            return .investments
        case .sport:
            return .sport
        case .healthcare:
            return .healthcare
        case .education:
            return .education
        case .travel:
            return .travel
        case .gifts:
            return .gift
        case .salary:
            return .salary
        case .other:
            return .other
        }
    }
    
    var name: String {
        switch self {
        case .foodAndDrinks:
            return "Food and drinks"
        case .shopping:
            return "Shopping"
        case .transport:
            return "Transport"
        case .payments:
            return "Payments"
        case .entertainment:
            return "Entertainment"
        case .car:
            return "Car"
        case .investments:
            return "Investments"
        case .sport:
            return "Sport"
        case .healthcare:
            return "Heealthcare"
        case .education:
            return "Education"
        case .travel:
            return "Travel"
        case .gifts:
            return "Gifts"
        case .salary:
            return "Salary"
        case .other:
            return "Other"
        }
    }
}
