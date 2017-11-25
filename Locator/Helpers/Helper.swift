//
//  Helper.swift
//  Locator
//
//  Created by Innocent Magagula on 11/18/17.
//  Copyright © 2017 Tucksee. All rights reserved.
//

import Foundation

class Helper {
    
    static func formatNumber(number: NSNumber,formatStyle: NumberFormatter.Style) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = formatStyle
        return numberFormatter.string(from: number)!
    }
}
