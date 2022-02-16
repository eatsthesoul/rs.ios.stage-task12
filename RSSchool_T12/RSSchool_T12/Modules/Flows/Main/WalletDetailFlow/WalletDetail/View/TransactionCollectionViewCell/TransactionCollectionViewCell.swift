//
//  TransactionCollectionViewCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 16.02.22.
//

import UIKit

class TransactionCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var imageView: BorderedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeGlassBackground(with: 20)
    }
    
    // MARK: - ConfigurableCell
    
    func configure(with item: TransactionCellViewModel) {
        imageView.image = item.image
        nameLabel.text = item.name
        dateLabel.text = item.date
        sumLabel.text = item.sum
        sumLabel.textColor = item.isOutcome ? .amaranthRed : .celadon
    }
}
