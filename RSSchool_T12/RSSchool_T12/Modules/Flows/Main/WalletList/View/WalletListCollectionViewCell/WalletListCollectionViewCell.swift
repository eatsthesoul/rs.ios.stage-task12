//
//  WalletListCollectionViewCell.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 11.02.22.
//

import UIKit

class WalletListCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: WalletCellViewModel) {
        titleLabel.text = item.title
        balanceLabel.text = item.balance
        dateLabel.text = item.lastChangeDate
    }

}
