//
//  HaxValueToRGB.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/02.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

struct HexValueToRGB {
    
    static func alphabetToNumber(alphabet: String) -> Int {
        switch alphabet {
        case "A":
            return 10
        case "a":
            return 10
        case "B":
            return 11
        case "b":
            return 11
        case "C":
            return 12
        case "c":
            return 12
        case "D":
            return 13
        case "d":
            return 13
        case "E":
            return 14
        case "e":
            return 14
        case "F":
            return 15
        case "f":
            return 15
        default:
            return Int(alphabet)!
        }
    }
    
    //16進数の値を10進数に変更
    static func sixTeenToTen(hexs: [String]) -> Int {
        var number = 0.0
        var sum = 0
        for hex in hexs {
            sum = sum + (HexValueToRGB.alphabetToNumber(alphabet: hex)*Int(pow(16.0, number)))
            number = number + 1.0
        }
        return sum
    }
    
    static func hexValueToRGB(hexValue: String, complition: @escaping (Int, Int, Int) -> Swift.Void) {
        //#を取る
        let hex = hexValue.replace(pattern: "#", with: "")
        //2つずつに分割
        let red16 = hex.pairsBy2[0]
        let green16 = hex.pairsBy2[1]
        let blue16 = hex.pairsBy2[2]
        
        let red = self.sixTeenToTen(hexs: red16.pairsBy1)
        let green = self.sixTeenToTen(hexs: green16.pairsBy1)
        let blue = self.sixTeenToTen(hexs: blue16.pairsBy1)
        
        complition(red, blue, green)
    }
    
    
    static func rangeJudge(category: String, season: String, red: Int, green: Int, blue: Int, complition: @escaping (Bool) -> Swift.Void) {
        var number = 0
        let minRedArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "red", maxOrMin: "min"))
        let maxRedArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "red", maxOrMin: "max"))
        let minGreenArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "green", maxOrMin: "min"))
        let maxGreenArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "green", maxOrMin: "max"))
        let minBlueArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "blue", maxOrMin: "min"))
        let maxBlueArray = LoadCsv.stringToIntArray(stringArray: LoadCsv.loadCsvFile(category: category, season: season, rgb: "blue", maxOrMin: "max"))
        
        for index in 0...(minRedArray.count-1) {
            if red >= (minRedArray[index]-10) && (maxRedArray[index]+10) >= red {
                if green >= (minGreenArray[index]-10) && (maxGreenArray[index]+10) >= green {
                    if blue >= (minBlueArray[index]-10) && (maxBlueArray[index]+10) >= blue {
                        complition(true)
                    }
                }
                
            } else {
                
            }
        }
    }
    
    
    
}



