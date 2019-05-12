//
//  QuizItem.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 08/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import Foundation
import Alamofire

class QuizItem{
    
    var imageArray:Array<UIImage>
    var randomIndex:Int
    var randomTitle:String
    
    init() {
        imageArray = Array<UIImage>()
        randomIndex = 0
        randomTitle = ""
    }
}
