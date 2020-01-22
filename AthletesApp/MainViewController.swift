//
//  MainViewController.swift
//  AthletesApp
//
//  Created by Aitor on 21/01/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Enums
    
    enum SegmentIndex : Int {
        case athletesIndex = 0
        case teamsIndex = 1
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Private Variables
    
    private var currentViewController: UIViewController?
    private lazy var athletesViewController: AthletesViewController? = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "AthletesViewController") as! AthletesViewController
        return viewController
    }()
    private lazy var teamsViewController: TeamsViewController = {
        var viewController = self.storyboard?.instantiateViewController(withIdentifier: "TeamsViewController") as! TeamsViewController
        return viewController
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = SegmentIndex.athletesIndex.rawValue
        displayCurrentTab(SegmentIndex.athletesIndex.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }

    // MARK: - Private Functions
    
    private func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = containerView.bounds
            containerView.addSubview(vc.view)
            currentViewController = vc
        }
    }
    
    private func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case SegmentIndex.athletesIndex.rawValue :
            vc = athletesViewController
        case SegmentIndex.teamsIndex.rawValue :
            vc = teamsViewController
        default:
            vc = nil
        }
    
        return vc
    }
    
    // MARK: - IBActions
    
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
}

