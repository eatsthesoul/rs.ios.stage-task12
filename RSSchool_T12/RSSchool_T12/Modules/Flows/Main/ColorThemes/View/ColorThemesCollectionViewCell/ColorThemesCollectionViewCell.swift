//
//  ColorThemesCollectionViewCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 24.01.22.
//

import UIKit

class ColorThemesCollectionViewCell: UICollectionViewCell, ConfigurableCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: ColorTheme) {
        let image = item.image
        imageView.image = image
    }
}
