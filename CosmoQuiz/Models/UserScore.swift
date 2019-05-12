//
//  Score.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 12/05/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import Foundation

class UserScore {
    var username = "Unknown"
    var score = ""
    
    init(username:String, score:String) {
        self.username = username
        self.score = score
    }
}
