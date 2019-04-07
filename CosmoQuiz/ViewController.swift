//
//  ViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 04/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet var ImageOutlet:[UIImageView]!
    
    let API_KEY = "uBHdRJkKAl917xAmxxaAqtRig5PtTzotpfw5v9v4"
    let photoCount = 4

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(API_KEY)&count=\(photoCount)"
        var responseJson:Array<[String:AnyObject]>  = []
        Alamofire.request(url).responseJSON(completionHandler:{ response in
            responseJson = response.result.value as! Array<[String:AnyObject]>
            for i in 0 ... self.photoCount-1{
                let ImageURL = URL(string: responseJson[i]["url"] as! String)!
                Alamofire.request(ImageURL).responseData { (response) in
                    if response.error == nil {
                        print(response.result)
                        if let data = response.data {
                            self.ImageOutlet[i].image = UIImage(data: data)
                        }
                    }
                }
            }
        })
    }
    


}

