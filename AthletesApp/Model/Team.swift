//
//  Team.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

class Team {
    
    let id: String
    let name: String?
    let sport: String?
    
    init(aId: String, aName: String?, aSport: String?) {
        id = aId
        name = aName
        sport = aSport
    }
}
