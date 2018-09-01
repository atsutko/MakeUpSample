//
//  LoadCSVFile.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/02.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

struct LoadCsv {
    
    static func loadCsvFile(category: String, season: String, rgb: String, maxOrMin: String) -> [String] {
        
        let csvPath = Bundle.main.path(forResource: "\(category)-\(season)-\(rgb)-\(maxOrMin)", ofType: "csv")
        do {
                let csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
                var lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
                lineChange = lineChange.replacingOccurrences(of: "\n\n", with: "\n")
                return lineChange.components(separatedBy: "\n")
            
        } catch {
            //load csvFile Error
            return []
        }
        
    }
    
    static func stringToIntArray(stringArray: [String]) -> [Int] {
        var intArray: [Int] = []
        for string in stringArray {
            if string != "" {
                intArray.append(Int(string)!)
            }
        }
        return intArray
    }
  
    
}
