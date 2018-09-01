//
//  String+Extention.swift
//  MakeUpSample
//
//  Created by TakaoAtsushi on 2018/09/02.
//  Copyright © 2018年 TakaoAtsushi. All rights reserved.
//

import UIKit

extension String {
    
    var pairsBy2: [String] {
        var result: [String] = []
        let characters = Array(self.characters)
        stride(from: 0, to: characters.count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, characters.count)]))
        }
        return result
    }
    
    var pairsBy1: [String] {
        var result: [String] = []
        let characters = Array(self.characters)
        stride(from: 0, to: characters.count, by: 1).forEach {
            result.append(String(characters[$0..<min($0+1, characters.count)]))
        }
        return result
    }
    
    
    var length: Int {
        let string = self as NSString
        return string.length
    }

    func replace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.length), withTemplate: with)
    }
    
}
