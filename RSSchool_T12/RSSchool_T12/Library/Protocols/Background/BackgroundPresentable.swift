//
//  BackgroundPresentable.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 19.01.22.
//

import UIKit

protocol BackgroundPresentable where Self: UIView {
    func makeGlassBackground(with cornerRadius: CGFloat)
    func makeThemeBackground()
    func removeBackground()
}

extension BackgroundPresentable {
    func makeGlassBackground(with cornerRadius: CGFloat = 0) {
        removeBackground()
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
        backgroundColor = .clear
    }
    
    func makeThemeBackground() {
        removeBackground()
        let backgroundView = ThemeView()
        backgroundView.isUserInteractionEnabled = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func removeBackground() {
        self.subviews.forEach { view in
            if view is BackgroundViewType {
                view.removeFromSuperview()
            }
        }
    }
    
}
