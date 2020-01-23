//
//  Athlete.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

class Athlete {

    let id: String
    let name: String?
    let sport: String?
    let surname: String?
    let weights: [Weight]?
    
    init(aId: String, aName: String?, aSport: String?, aSurname: String?, aWeights: [Weight]?) {
        id = aId
        name = aName
        sport = aSport
        surname = aSurname
        weights = aWeights
    }
}
