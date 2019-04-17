//
//  ViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 04/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class Quiz: UIViewController {
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var ImageOutlet:[UIImageView]!
    @IBOutlet weak var titleLabel: UILabel!
    
    var correctImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuizItem()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func nextQuizItem() {
        hideUIElements()
        NasaAPI.request.getQuizItem(completion:{quizItem in
            self.showUIElements(quizItem: quizItem!)
        })
    }
    
    func hideUIElements(){
        titleLabel.isHidden = true;
        for i in 0 ... 3{
            self.activityIndicator.startAnimating()
            self.ImageOutlet[i].isHidden = true
        }
    }
    
    func showUIElements(quizItem:QuizItem){
        titleLabel.text = quizItem.randomTitle;
        titleLabel.isHidden = false;
        correctImage = quizItem.randomIndex
        for i in 0 ... quizItem.imageArray.count-1{
            self.ImageOutlet[i].image = quizItem.imageArray[i]
            self.ImageOutlet[i].layer.borderWidth = 0
            self.ImageOutlet[i].isHidden = false
        }
        self.activityIndicator.stopAnimating()
    }
    
    @IBAction func tapped1(_ sender: Any) {
        highlightImages(selectedImage:0)
        sleep(1)
        nextQuizItem()
    }
    
    @IBAction func tapped2(_ sender: Any) {
        highlightImages(selectedImage:1)
        sleep(1)
        nextQuizItem()
    }
    
    @IBAction func tapped3(_ sender: Any) {
        highlightImages(selectedImage:2)
        sleep(1)
        nextQuizItem()
    }
    
    @IBAction func tapped4(_ sender: Any) {
        highlightImages(selectedImage:3)
        sleep(1)
        nextQuizItem()
    }
    
    func highlightImages(selectedImage:Int){
        ImageOutlet[selectedImage].layer.borderWidth = 10
        if(selectedImage == correctImage){
            ImageOutlet[selectedImage].layer.borderColor = UIColor.green.cgColor
        }else{
            ImageOutlet[correctImage].layer.borderWidth = 10
            ImageOutlet[selectedImage].layer.borderColor = UIColor.red.cgColor
            ImageOutlet[correctImage].layer.borderColor = UIColor.green.cgColor
        }
    }
    
}

