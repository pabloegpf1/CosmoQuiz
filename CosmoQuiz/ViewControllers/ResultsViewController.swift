//
//  ResultsViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 28/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var earnedPointsLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    
    var results: String = ""
    var points: String = ""
    var total: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        earnedPointsLabel.text = points
        totalPointsLabel.text = total
        resultsLabel.text = results
    }

}
