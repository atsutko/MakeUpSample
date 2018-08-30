//
//  CosmeTableViewCell.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/08/30.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

class CosmeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productColorLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
