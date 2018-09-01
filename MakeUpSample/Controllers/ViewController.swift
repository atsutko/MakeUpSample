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
import TTTAttributedLabel

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CosmeTableViewCellDelegate {
    
    @IBOutlet weak var cosmeTableView: UITableView!
    
    var searchBar: UISearchBar!
    
    var cosmeArray = [Cosme]()
    var imageArray = [UIImage]()
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cosmeTableView.delegate = self
        cosmeTableView.dataSource = self
        
        let nib = UINib(nibName: "CosmeTableViewCell", bundle: Bundle.main)
        cosmeTableView.register(nib, forCellReuseIdentifier: "cosmeCell")
        
        cosmeTableView.rowHeight = 380.0
        cosmeTableView.tableFooterView = UIView()
        
        setSearchBar()
        
        loadCosmetics(searchText: "maybelline")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setSearchBar() {
        if let navigationBarFrame = self.navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "化粧品を検索"
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
    
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel) {
        self.selectedIndex = tableViewCell.tag
        self.performSegue(withIdentifier: "toWebView", sender: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadCosmetics(searchText: nil)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadCosmetics(searchText: searchBar.text!)
    }
    
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadCosmetics(refreshControl:)), for: .valueChanged)
        cosmeTableView.addSubview(refreshControl)
    }
    
    @objc func reloadCosmetics(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.loadCosmetics(searchText: searchBar.text)
        // 更新が早すぎるので2秒遅延させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            refreshControl.endRefreshing()
        }
    }
    
    
    func loadCosmetics(searchText: String?) {
        MakeUpAPI.getCosmeticsFromBrand(brand: searchText!) { (results, success) in
            if success == false {
                //エラー
            } else {
                //成功
                if results.count != 0 {
                    for result in results {
                        let productName = result["name"] as! String
                        let productDescription = result["description"] as! String
                        let productPrice = result["price"] as! String
                        let productType = result["product_type"] as! String
                        let productColors = result["product_colors"] as! [NSDictionary]
                        for productColor in productColors {
                            if let color = productColor["colour_name"] as? String {
                                let productBrand = result["brand"] as! String
                                let imageUrl = result["image_link"] as! String
                                let webUrl = result["product_link"] as! String
                                let cosme = Cosme(productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl, productWebUrl: webUrl)
                                self.cosmeArray.append(cosme)
                            }
                        }
                        DispatchQueue.main.async {
                            self.cosmeTableView.reloadData()
                        }
                    }
                } else {
                    MakeUpAPI.getCosmeticsFromProductType(productType: searchText!, complition: { (results, success) in
                        if success == false {
                            
                        } else {
                            if results.count != 0 {
                                for result in results {
                                    let productName = result["name"] as! String
                                    let productDescription = result["description"] as! String
                                    let productPrice = result["price"] as! String
                                    let productType = result["product_type"] as! String
                                    let productColors = result["product_colors"] as! [NSDictionary]
                                    for productColor in productColors {
                                        if let color = productColor["colour_name"] as? String {
                                            let productBrand = result["brand"] as! String
                                            let imageUrl = result["image_link"] as! String
                                            let webUrl = result["product_link"] as! String
                                            let cosme = Cosme(productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl, productWebUrl: webUrl)
                                            self.cosmeArray.append(cosme)
                                        }
                                    }
                                    DispatchQueue.main.async {
                                        self.cosmeTableView.reloadData()
                                    }
                                }
                            }
                        }
                    })
                }
            }
        }
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

