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

class QuizViewController: UIViewController {
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var ImageOutlet:[UIImageView]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var correctCounter = 0
    var totalPoints = 0
    var correctImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true
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
    }
    
    @IBAction func tapped2(_ sender: Any) {
        highlightImages(selectedImage:1)
    }
    
    @IBAction func tapped3(_ sender: Any) {
        highlightImages(selectedImage:2)
    }
    
    @IBAction func tapped4(_ sender: Any) {
        highlightImages(selectedImage:3)
    }
    
    func highlightImages(selectedImage:Int){ //CHECK IF CORRECT
        if(selectedImage == correctImage){ //CORRECT
            ImageOutlet[selectedImage].backgroundColor = UIColor.green
            ImageOutlet[selectedImage].alpha = 0.5
            self.correctCounter += 1
            print("CORRECT:\(selectedImage)")
        }else{ // INCORRECT
            ImageOutlet[correctImage].backgroundColor = UIColor.green
            ImageOutlet[selectedImage].backgroundColor = UIColor.red
            ImageOutlet[correctImage].alpha = 0.5
            ImageOutlet[selectedImage].alpha = 0.5
            print("INCORRECT: \(selectedImage)---CORRECT: \(correctImage)")
        }
        sleep(1)
        print("POINTS: \(correctCounter)")
        ImageOutlet[correctImage].alpha = 1
        ImageOutlet[selectedImage].alpha = 1
        progressBar.progress += 0.2
        if(progressBar.progress < 1){
            nextQuizItem()
        }else{
            print("END")
            sendResults()
        }
    }
    
    func sendResults(){
        FirebaseAPI.request.getTotalPoints(completion: {score in
            if(score == nil){
                self.totalPoints = 0
            }else{
                self.totalPoints = score!
            }
            FirebaseAPI.request.recordScore(score: self.correctCounter*10, completion: { error in
                self.performSegue(withIdentifier: "quizToResults", sender: nil)
            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizToResults" {
            let viewController = segue.destination as! ResultsViewController
            viewController.points = "\(correctCounter * 10)"
            viewController.total = "\(totalPoints)"
            viewController.results = "You got \(correctCounter) out of 5"
        }
    }
    
}

