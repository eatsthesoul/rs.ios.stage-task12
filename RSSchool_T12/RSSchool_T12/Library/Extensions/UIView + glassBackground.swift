//
//  UIView.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 17.01.22.
//

import UIKit

extension UIView {
    func makeGlassBackground(with cornerRadius: CGFloat = 0) {
        let glassView = GlassView(with: cornerRadius)
        glassView.isUserInteractionEnabled = false
        glassView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(glassView, at: 0)
        NSLayoutConstraint.activate([
            glassView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            glassView.topAnchor.constraint(equalTo: self.topAnchor),
            glassView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            glassView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.backgroundColor = .clear
    }
}
