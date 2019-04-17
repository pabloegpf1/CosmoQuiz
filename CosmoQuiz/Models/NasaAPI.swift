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
    
    let url = "https://api.nasa.gov/planetary/apod?api_key=\(ProcessInfo.processInfo.environment["nasaApiKey"] ?? "")&count=4"
    
    static let request = NasaAPI()
    
    func getQuizItem(completion: @escaping (QuizItem?) -> ()){
        
        var json:Array<[String:AnyObject]> = []
        let quizItem:QuizItem = QuizItem()
        let jsonRequest = DispatchGroup()
        
        jsonRequest.enter()
        Alamofire.request(url).responseJSON{ response in
            json = response.result.value as! Array<[String:AnyObject]>
  
            quizItem.randomIndex = Int.random(in: 0 ... 3)
            quizItem.randomTitle = json[quizItem.randomIndex]["title"] as! String

            jsonRequest.leave()
        }
        
        jsonRequest.notify(queue: .main) {
            
            let imageDownload = DispatchGroup()
            for i in 0 ... json.count-1{
                print("URL: ---->\(json[i]["url"] as! String)")
                imageDownload.enter()
                Alamofire.request(json[i]["url"] as! String).responseData { response in
                    if response.error == nil {
                        if let data = response.data {
                            quizItem.imageArray.append(UIImage(data: data)!)
                        }
                    }else{
                        print("Error: could not download Images")
                        completion(nil)
                    }
                    imageDownload.leave()
                }
            }
            
            imageDownload.notify(queue: .main) {
                completion(quizItem)
            }
        }
    }
    
}
