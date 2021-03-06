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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Private Variables
    
    private var ref: DatabaseReference! = Database.database().reference()
    private var athletes = [Athlete]()
    private var filteredAthletes = [Athlete]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupCollectionView()
        getAthletes()
    }
    
    // MARK: - Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let athleteDetailVC = segue.destination as? AthleteDetailViewController, let cell = sender as? AthleteCollectionViewCell, let selectedRow = athletesCollectionView.indexPath(for: cell)?.row {
            athleteDetailVC.athlete = filteredAthletes[selectedRow]
        }
    }

    // MARK: - Private Functions
    
    private func setupSearchBar() {
        searchBar.changeSearchBarColor(color: UIColor.clear)
        let txtFieldInsideSearchBar = searchBar.value(forKey: "searchField") as! UITextField
        txtFieldInsideSearchBar.textColor = UIColor.black
        txtFieldInsideSearchBar.backgroundColor = UIColor.init(red: 61, green: 71, blue: 98, alpha: 1)
        searchBar.tintColor = UIColor.black
        searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        athletesCollectionView.delegate = self
        athletesCollectionView.dataSource = self
    }
    
    private func getAthletes() {
        self.showSpinner(onView: self.view)
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshotTeams = snapshot.value as? [String : [String:Any]] {
                    for (key, value) in snapshotTeams {
                        var weights: [Weight] = []
                        if let athleteWeights = value["weights"] as? [String : Any] {
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
            self.filteredAthletes = self.athletes
            self.removeSpinner()
            self.athletesCollectionView.reloadData()
          }) { (error) in
            self.removeSpinner()
            print(error.localizedDescription)
        }
    }
}

// MARK: - UICollectionView Data Source and Delegate

extension AthletesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredAthletes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4.0
        return CGSize(width: width, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "athleteCell", for: indexPath) as! AthleteCollectionViewCell
        cell.drawData(athlete: filteredAthletes[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBar Delegate

extension AthletesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredAthletes = athletes.filter { $0.name?.range(of: searchText, options: .caseInsensitive) != nil }
        } else {
            filteredAthletes = athletes
        }
        self.athletesCollectionView.reloadData()
    }
}
