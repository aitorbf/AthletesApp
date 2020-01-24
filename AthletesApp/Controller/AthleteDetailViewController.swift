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
    
    @IBOutlet weak var athleteImageView: UIImageView!
    @IBOutlet weak var athleteDetailsTableView: UITableView!
    
    // MARK: - Public Variables
    
    var athlete: Athlete?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        athleteImageView.layer.cornerRadius = athleteImageView.bounds.size.width / 2.0
        setupTableView()
    }
    
    private func setupTableView() {
        athleteDetailsTableView.delegate = self
        athleteDetailsTableView.dataSource = self
    }

}

// MARK: - UITableView Data Source and Delegate

extension AthleteDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Personal Data"
        case 1:
            return "Weights"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return athlete?.weights?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var athleteDetailCell: UITableViewCell?
        if indexPath.section == 0 {
            athleteDetailCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "athleteDetailCell")
            switch indexPath.row {
            case 0:
                athleteDetailCell?.textLabel?.text = "Name"
                athleteDetailCell?.detailTextLabel?.text = athlete?.name
            case 1:
                athleteDetailCell?.textLabel?.text = "Surname"
                athleteDetailCell?.detailTextLabel?.text = athlete?.surname
            case 2:
                athleteDetailCell?.textLabel?.text = "Sport"
                athleteDetailCell?.detailTextLabel?.text = athlete?.sport
            default:
                break
            }
        } else {
            athleteDetailCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "athleteDetailCell")
            athleteDetailCell?.textLabel?.text = athlete?.weights?[indexPath.row].getDateAsString()
            athleteDetailCell?.detailTextLabel?.text = "\(athlete?.weights?[indexPath.row].getRoundedValue() ?? "0.0") Kg"
        }
        athleteDetailCell?.selectionStyle = .none
        return athleteDetailCell!
    }
}
