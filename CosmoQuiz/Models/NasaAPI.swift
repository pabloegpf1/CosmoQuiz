//
//  NasaAPI.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 08/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import Foundation
import Alamofire

struct NasaAPI{
    
    static let request = NasaAPI()
    
    let jsonRequest = DispatchGroup()
    let imageDownload = DispatchGroup()
    
    func getQuizItem(completion: @escaping (QuizItem?) -> ()){
        
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(ProcessInfo.processInfo.environment["nasaApiKey"] ?? "")&count=4"
        var json:Array<[String:AnyObject]> = []
        let quizItem:QuizItem = QuizItem()
        
        jsonRequest.enter()
        Alamofire.request(url).responseJSON{ response in
            json = response.result.value as! Array<[String:AnyObject]>
  
            quizItem.randomIndex = Int.random(in: 0 ... 3)
            quizItem.randomTitle = json[quizItem.randomIndex]["title"] as! String

            self.jsonRequest.leave()
        }
        
        jsonRequest.notify(queue: .main) {
            
            for i in 0 ... json.count-1{
                print("URL: ---->\(json[i]["url"] as! String)")
                self.imageDownload.enter()
                Alamofire.request(json[i]["url"] as! String).responseData { response in
                    if response.error == nil {
                        if let data = response.data {
                            quizItem.imageArray.append(UIImage(data: data)!)
                        }
                    }else{
                        print("Error: could not download Images")
                        completion(nil)
                    }
                    self.imageDownload.leave()
                }
            }
            
            self.imageDownload.notify(queue: .main) {
                completion(quizItem)
            }
        }
    }
    
    func getDiscoverItem(date:String,completion: @escaping (DiscoverItem?) -> ()){
        
        let url = "https://api.nasa.gov/planetary/apod?api_key=\(ProcessInfo.processInfo.environment["nasaApiKey"] ?? "")&date=\(date)"
        let discoverItem:DiscoverItem = DiscoverItem()
        var json:[String:AnyObject] = [:]
        
        jsonRequest.enter()
        Alamofire.request(url).responseJSON{ response in
            print("RESPONSE: \(response)")
            json = response.result.value as! [String:AnyObject]
            
            discoverItem.title = json["title"] as! String
            discoverItem.description = json["explanation"] as! String
            
            self.jsonRequest.leave()
        }
        
        jsonRequest.notify(queue: .main) {
            self.imageDownload.enter()
            Alamofire.request(json["url"] as! String).responseData { response in
                guard let image = UIImage(data: response.data!) else{
                    print("Error: could not download Image")
                    return
                }
                discoverItem.image = image
                self.imageDownload.leave()
            }
            self.imageDownload.notify(queue: .main) {
                completion(discoverItem)
            }
        }
        
    }
    
}
