//
//  AthletesViewController.swift
//  AthletesApp
//
//  Created by Aitor on 22/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit
import Firebase

class AthletesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var athletesCollectionView: UICollectionView!
    
    // MARK: - Private Variables
    
    private var ref: DatabaseReference! = Database.database().reference()
    private var athletes: [Athlete] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        getAthletes()
    }

    // MARK: - Private Functions
    
    private func setupCollectionView() {
        athletesCollectionView.delegate = self
        athletesCollectionView.dataSource = self
    }
    
    private func getAthletes() {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshotTeams = snapshot.value as? [String : [String:Any]] {
                    for (key, value) in snapshotTeams {
                        var weights: [Weight] = []
                        if let athleteWeights = value["weights"] as? Dictionary<String, Any> {
                            for (key, value) in athleteWeights {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let date = dateFormatter.date(from:key)!
                                let weight = Weight(aDate: date, aValue: (value as? NSNumber)?.floatValue)
                                weights.append(weight)
                            }
                            weights = weights.sorted(by: { $0.date > $1.date })
                        }
                        let athlete = Athlete(
                            aId: key,
                            aName: value["name"] as? String,
                            aSport: value["sport"] as? String,
                            aSurname: value["surname"] as? String,
                            aWeights: weights
                        )
                        self.athletes.append(athlete)
                    }
                }
            } else {
                self.athletes = []
            }
            self.athletesCollectionView.reloadData()
          }) { (error) in
            print(error.localizedDescription)
        }
    }
}

extension AthletesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        athletes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4.0
        return CGSize(width: width, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "athleteCell", for: indexPath) as! AthleteCollectionViewCell
        cell.drawData(name: athletes[indexPath.row].name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) selected")
    }
}
