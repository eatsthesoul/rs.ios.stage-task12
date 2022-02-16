//
//  Date.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16.02.22.
//

import Foundation

extension Date {
    
    func string(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
}
