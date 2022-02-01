//
//  CurrencyListCollectionViewCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 1.02.22.
//

import UIKit

class CurrencyListCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configure(with item: CurrencyCellViewModel) {
        nameLabel.text = item.name
        codeLabel.text = item.code
    }
}
