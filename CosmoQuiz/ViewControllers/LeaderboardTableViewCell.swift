//
//  LeaderboardTableViewCell.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 12/05/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = ""
    var username = "Unknown"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(){
        self.usernameLabel.text = username
        self.scoreLabel.text = score
    }

}
