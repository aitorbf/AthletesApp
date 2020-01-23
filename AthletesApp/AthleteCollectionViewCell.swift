//
//  AthleteCollectionViewCell.swift
//  AthletesApp
//
//  Created by Aitor on 23/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class AthleteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func drawData(athlete: Athlete) {
        nameLabel.text = athlete.name
    }
    
}
