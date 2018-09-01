//
//  ProductTypeTableViewCell.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/01.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

class ProductTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var productTypeNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
