//
//  Weight.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

struct Weight: Codable {
    
    let date: String?
    let value: Float?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case value = "value"
    }
}

