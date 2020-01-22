//
//  Team.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

struct Team: Codable {
    
    let id: String
    let name: String?
    let sport: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sport = "sport"
    }
}
