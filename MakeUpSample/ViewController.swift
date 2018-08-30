//
//  ViewController.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/08/29.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var cosmeTableView: UITableView!
    
    var cosmeArray = [Cosme]()
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cosmeTableView.delegate = self
        cosmeTableView.dataSource = self
        
        let nib = UINib(nibName: "CosmeTableViewCell", bundle: Bundle.main)
        cosmeTableView.register(nib, forCellReuseIdentifier: "cosmeCell")
        
        cosmeTableView.rowHeight = 280.0
        cosmeTableView.tableFooterView = UIView()
        
        MakeUpAPI.getCosmeticsFromBrand(brand: "maybelline") { (results, success) in
            if success == false {
                //エラー
            } else {
                //成功
                for result in results {
                    let productName = result["name"] as! String
                    let productPrice = result["price"] as! String
                    let productType = result["product_type"] as! String
                    let productColors = result["product_colors"] as! [NSDictionary]
                    for productColor in productColors {
                        if let color = productColor["colour_name"] as? String {
                            let productBrand = result["brand"] as! String
                            let imageUrl = result["image_link"] as! String
                            
                            let cosme = Cosme(productName: productName, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl)
                            self.cosmeArray.append(cosme)
                        }
                    }
                    
                  
                    
                    DispatchQueue.main.async {
                        self.cosmeTableView.reloadData()
                    }
                    
                }
            }
        }
      
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmeArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cosmeCell") as! CosmeTableViewCell
        cell.productNameLabel.text = cosmeArray[indexPath.row].productName
        cell.productTypeLabel.text = cosmeArray[indexPath.row].productType
        cell.productBrandLabel.text = cosmeArray[indexPath.row].productBrand
        cell.productColorLabel.text = cosmeArray[indexPath.row].productColor
        cell.productPriceLabel.text = cosmeArray[indexPath.row].productPrice
        cell.productImageView.sd_setImage(with: URL(string: cosmeArray[indexPath.row].productImageUrl), completed: nil)

        return cell
    }
    
    
    
    
    
}

