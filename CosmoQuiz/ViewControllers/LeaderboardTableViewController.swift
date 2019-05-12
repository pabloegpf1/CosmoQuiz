//
//  LeaderboardTableViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 12/05/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    var scoreList = [UserScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getScoreList()
    }
    
    func getScoreList(){
        FirebaseAPI.request.getLeaderboard { (scoreList) in
            self.scoreList = scoreList as! [UserScore]
            self.scoreList.reverse()
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userScore = scoreList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! LeaderboardTableViewCell
        cell.username = userScore.username
        cell.score = userScore.score
        cell.update()
        return cell
    }

}
