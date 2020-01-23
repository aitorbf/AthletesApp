//
//  Weight.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class Weight {
    
    let date: Date
    let value: Float?
    
    init(aDate: Date, aValue: Float?) {
        date = aDate
        value = aValue
    }
    
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func getRoundedValue() -> Float? {
        return Float(String(format: "%.2f", value ?? 0))
    }
}

