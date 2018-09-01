//
//  ProductTypeViewController.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/01.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

class ProductTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var productTypeTableView: UITableView!
    
    var productTypeNameArray: [String] = ["Blush", "Bronzer", "EyeBlow", "Eyeliner", "Eyeshadow", "Foundation", "Liplinear", "Lipstick", "Mascara", "NailPolish"]

    override func viewDidLoad() {
        super.viewDidLoad()

        productTypeTableView.dataSource = self
        productTypeTableView.delegate = self
        
        let nib = UINib(nibName: "ProductTypeTableViewCell", bundle: Bundle.main)
        productTypeTableView.register(nib, forCellReuseIdentifier: "productTypeCell")
        
        productTypeTableView.tableFooterView = UIView()
        productTypeTableView.rowHeight = 44.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toSeasonSelectViewController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTypeCell") as! ProductTypeTableViewCell
        cell.productTypeNameLabel.text = productTypeNameArray[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectSeasonViewController = segue.destination as! SelectSeasonViewController
        let selectedIndexPath = productTypeTableView.indexPathForSelectedRow!
        selectSeasonViewController.selectedCategory = productTypeNameArray[selectedIndexPath.row]
    }

}
