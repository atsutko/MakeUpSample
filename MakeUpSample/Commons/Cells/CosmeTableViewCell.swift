//
//  CosmeTableViewCell.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/08/30.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit
import TTTAttributedLabel

protocol CosmeTableViewCellDelegate {
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel)
}

class CosmeTableViewCell: UITableViewCell, TTTAttributedLabelDelegate {
    
    var delegate: CosmeTableViewCellDelegate?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productColorLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productWebUrlLabel: TTTAttributedLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        productWebUrlLabel.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        productWebUrlLabel.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.delegate?.didTapLink(tableViewCell: self, label: label)
    }
    
    
    
}
