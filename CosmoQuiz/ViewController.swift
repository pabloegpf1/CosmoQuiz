//
//  ViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 04/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let API_KEY = "uBHdRJkKAl917xAmxxaAqtRig5PtTzotpfw5v9v4"
    let photoCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(API_KEY)&count=\(photoCount)"
        
        Alamofire.request(url).responseJSON(completionHandler:{ response in
            guard
                let json = response.result.value as? [String:Any]
            else{
                print("Error retrieving JSON")
                return
            }
            print("JSON: \(json)")
        })
        
    }


}

