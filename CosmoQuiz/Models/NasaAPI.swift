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
    let dateFormatter = DateFormatter()
    
    func getQuizItem(completion: @escaping (QuizItem?) -> ()){
        
        var url = "https://nasa-apod-cosmoquiz.herokuapp.com/api/?count=4&thumbs=true"
        print(url)
        var json:Array<[String:AnyObject]> = []
        let quizItem:QuizItem = QuizItem()
        
        var safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        jsonRequest.enter()
        Alamofire.request(safeURL).responseJSON{ response in
            
            json = response.result.value as! Array<[String:AnyObject]>
  
            quizItem.randomIndex = Int.random(in: 0 ... 3)
            quizItem.randomTitle = json[quizItem.randomIndex]["title"] as! String

            self.jsonRequest.leave()
        }
        
        jsonRequest.notify(queue: .main) {
            
            for i in 0 ... json.count-1 {
                print("URL: ---->\(json[i]["url"] as! String)")
                self.imageDownload.enter()
                var imageParameter = "url"
                if(json[i]["media_type"] as! String == "video"){
                    imageParameter = "thumbnail_url"
                }
                url = json[i][imageParameter]! as! String
                safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                Alamofire.request(safeURL).responseData { response in
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
    
    func getAPODItem(date:String,completion: @escaping (ApodItem?) -> ()){
        
        var url = "https://nasa-apod-cosmoquiz.herokuapp.com/api/?date=\(date)&thumbs=true"
        let apodItem:ApodItem = ApodItem()
        var json:[String:AnyObject] = [:]
        
        var safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        jsonRequest.enter()
        Alamofire.request(safeURL).responseJSON{ response in
            print("RESPONSE: \(response)")
            json = response.result.value as! [String:AnyObject]
            
            apodItem.title = json["title"] as? String ?? ""
            apodItem.description = json["description"] as? String ?? ""
            
            self.jsonRequest.leave()
        }
        
        jsonRequest.notify(queue: .main) {
            self.imageDownload.enter()
            var imageParameter = "url"
            if(json["media_type"] as! String == "video"){
                imageParameter = "thumbnail_url"
            }
            url = json[imageParameter] as! String
            safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            Alamofire.request(safeURL).responseData { response in
                guard let image = UIImage(data: response.data!) else{
                    print("Error: could not download Image")
                    return
                }
                apodItem.image = image
                self.imageDownload.leave()
            }
            self.imageDownload.notify(queue: .main) {
                completion(apodItem)
            }
        }
        
    }
    
}
