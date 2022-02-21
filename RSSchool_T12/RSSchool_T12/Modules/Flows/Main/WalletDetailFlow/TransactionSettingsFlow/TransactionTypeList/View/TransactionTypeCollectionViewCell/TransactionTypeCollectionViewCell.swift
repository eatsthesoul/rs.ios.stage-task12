//
//  TransactionTypeCollectionViewCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 21.02.22.
//

import UIKit

class TransactionTypeCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeGlassBackground(with: 20)
        imageView.makeBorderBackground(with: 10)
    }
    
    func configure(with item: TransactionTypeCellViewModel) {
        titleLabel.text = item.title
        imageView.image = item.image
    }

}
