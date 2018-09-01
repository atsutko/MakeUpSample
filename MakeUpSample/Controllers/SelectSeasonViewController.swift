//
//  SelectSeasonViewController.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/02.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

class SelectSeasonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var seasonTableView: UITableView!
    
    var season = ["spring", "summer", "autumn", "winter"]
    var selectedCategory: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonTableView.delegate = self
        seasonTableView.dataSource = self
        
        seasonTableView.tableFooterView = UIView()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  season.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell")!
        cell.textLabel?.text = season[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toCosmeListViewController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cosmeListViewController = segue.destination as! CosmeListViewController
        let selectedIndex = seasonTableView.indexPathForSelectedRow!
        cosmeListViewController.selectedCategory = self.selectedCategory
        cosmeListViewController.selectedSeason = season[selectedIndex.row]
    }
    
    
    

}
