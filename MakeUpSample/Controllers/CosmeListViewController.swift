//
//  CosmeListViewController.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/01.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit
import SDWebImage
import TTTAttributedLabel

class CosmeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CosmeTableViewCellDelegate {
    
    @IBOutlet weak var cosmeListTableView: UITableView!
    
    var selectedCategory: String = ""
    var selectedIndex: Int = 0
    var cosmeArray: [Cosme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cosmeListTableView.dataSource = self
        cosmeListTableView.delegate = self
        
        let nib = UINib(nibName: "CosmeTableViewCell", bundle: Bundle.main)
        cosmeListTableView.register(nib, forCellReuseIdentifier: "cosmeCell")
        
        cosmeListTableView.rowHeight = 380.0
        cosmeListTableView.tableFooterView = UIView()
        
        loadCosmetics(category: self.switchCategory(selectedCategory: selectedCategory)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchCategory(selectedCategory: String) -> String? {
        switch selectedCategory {
        case "Blush":
            return productType.blush.rawValue
        case "Bronzer":
            return productType.bronzer.rawValue
        case "EyeBlow":
            return productType.eyebrow.rawValue
        case "Eyeliner":
            return productType.eyeliner.rawValue
        case "Eyeshadow":
            return productType.eyeshadow.rawValue
        case "Foundation":
            return productType.foundation.rawValue
        case "Liplinear":
            return productType.lip_liner.rawValue
        case "Lipstick":
            return productType.lipstick.rawValue
        case "Mascara":
            return productType.mascara.rawValue
        case "NailPolish":
            return productType.nail_polish.rawValue
        default:
            return nil
        }
    }
    
    func loadCosmetics(category: String) {
        MakeUpAPI.getCosmeticsFromProductType(productType: category) { (results, success) in
            if success == false {
                //エラー
            } else {
                //成功
                for result in results {
                    let productName = result["name"] as! String
                    if let productDescription = result["description"] as? String {
                        if let productPrice = result["price"] as? String {
                            let productType = result["product_type"] as! String
                            let productColors = result["product_colors"] as! [NSDictionary]
                            for productColor in productColors {
                                if let color = productColor["colour_name"] as? String {
                                    if let productBrand = result["brand"] as? String {
                                        let imageUrl = result["image_link"] as! String
                                        let webUrl = result["product_link"] as! String
                                        let cosme = Cosme(productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl, productWebUrl: webUrl)
                                        self.cosmeArray.append(cosme)
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    self.cosmeListTableView.reloadData()
                                }
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel) {
        self.selectedIndex = tableViewCell.tag
        self.performSegue(withIdentifier: "toNext", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cosmeCell") as! CosmeTableViewCell
        
        cell.delegate = self
        cell.tag = indexPath.row
        
        cell.productNameLabel.text = cosmeArray[indexPath.row].productName
        cell.productDescriptionTextView.text = cosmeArray[indexPath.row].productDescription
        cell.productTypeLabel.text = cosmeArray[indexPath.row].productType
        cell.productBrandLabel.text = cosmeArray[indexPath.row].productBrand
        cell.productColorLabel.text = cosmeArray[indexPath.row].productColor
        cell.productPriceLabel.text = cosmeArray[indexPath.row].productPrice
        cell.productImageView.sd_setImage(with: URL(string: cosmeArray[indexPath.row].productImageUrl), completed: nil)
        cell.productWebUrlLabel.text = cosmeArray[indexPath.row].productWebUrl
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let explainWebViewController = segue.destination as! ExplainWebViewController
        let selectedIndex = self.selectedIndex
        explainWebViewController.url = cosmeArray[selectedIndex].productWebUrl
    }
    
    
    
}
