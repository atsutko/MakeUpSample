//
//  Cosme.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/08/29.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

enum productType: String {
    case blush
    case bronzer
    case eyebrow
    case eyeliner
    case eyeshadow
    case foundation
    case lip_liner
    case lipstick
    case mascara
    case nail_polish
}



class Cosme {
    
    var productName: String
    var productDescription: String
    var productPrice: String
    var productBrand: String
    var productType: String
    var productColor: String
    var productImageUrl: String
    var productWebUrl:String
    
    init(productName: String, productDescription: String, productPrice: String, productBrand: String, productType: String, productColor: String, productImageUrl: String, productWebUrl: String) {
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productBrand = productBrand
        self.productType = productType
        self.productColor = productColor
        self.productImageUrl = productImageUrl
        self.productWebUrl = productWebUrl
    }
    
    
   

}
