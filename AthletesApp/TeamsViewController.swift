//
//  TeamsViewController.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit
import Firebase

class TeamsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var teamsTableView: UITableView!
    
    // MARK: - Private Variables
    
    private var ref: DatabaseReference! = Database.database().reference()
    private var teams: [Team] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getTeams()
    }
    
    // MARK: - Private Functions
    
    private func setupTableView() {
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
    }
    
    private func getTeams() {
        ref.child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshotTeams = snapshot.value as? [String : [String:Any]] {
                    for (key, value) in snapshotTeams {
                        let team = Team(
                            aId: key,
                            aName: value["name"] as? String,
                            aSport: value["sport"] as? String
                        )
                        self.teams.append(team)
                    }
                }
            } else {
                self.teams = []
            }
            self.teamsTableView.reloadData()
          }) { (error) in
            print(error.localizedDescription)
        }
    }

}

extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "teamCell")
        teamCell.textLabel?.text = teams[indexPath.row].name
        teamCell.detailTextLabel?.text = teams[indexPath.row].sport
        teamCell.selectionStyle = .none
        return teamCell
    }
    
}
