//
//  DiscoverItem.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 18/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import Foundation
import Alamofire

class ApodItem{
    var title:String
    var image:UIImage
    var description:String
    var date:Date
    
    init(){
        self.title = ""
        self.image = UIImage()
        self.description = ""
        self.date = Date()
    }

}

