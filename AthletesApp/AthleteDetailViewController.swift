//
//  AthleteDetailViewController.swift
//  AthletesApp
//
//  Created by Aitor on 24/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class AthleteDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var athleteName: UILabel!
    
    // MARK: - Public Variables
    
    var athlete: Athlete?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let athlete = athlete {
            drawData(athlete: athlete)
        }
        // Do any additional setup after loading the view.
    }
    
    private func drawData(athlete: Athlete) {
        athleteName.text = athlete.name
    }

}
