//
//  Athlete.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

struct Athlete: Codable {
    
    let id: String
    let name: String?
    let sport: String?
    let surname: String?
    let weights: [Weight]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sport = "sport"
        case surname = "surname"
        case weights = "weights"
    }
}
