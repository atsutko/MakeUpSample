//
//  Cosme.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/08/29.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

class Cosme {
    
    var productName: String
    var productPrice: String
    var productBrand: String
    var productType: String
    var productColor: String
    var productImageUrl: String
    
    init(productName: String, productPrice: String, productBrand: String, productType: String, productColor: String, productImageUrl: String) {
        self.productName = productName
        self.productPrice = productPrice
        self.productBrand = productBrand
        self.productType = productType
        self.productColor = productColor
        self.productImageUrl = productImageUrl
    }
    

}
