//
//  ConfigurableCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 26.01.22.
//

import Foundation

public protocol ConfigurableCell {
    associatedtype T

    func configure(with item: T)
}
