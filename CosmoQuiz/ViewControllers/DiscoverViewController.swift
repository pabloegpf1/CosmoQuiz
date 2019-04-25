//
//  Discover.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 18/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    let currentDate = Date()
    var selectedDate = Date()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionBox: UITextView!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.buttons{
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
        }
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = getRandomDate()
        refreshUIElements()
    }
    
    func refreshUIElements(){
        let dateString = dateFormatter.string(from: self.selectedDate)
        NasaAPI.request.getAPODItem(date: dateString, completion: { apodItem in
            if(apodItem == nil){
                print("youtube url")
                self.refreshUIElements()
            }else{
                self.titleLabel.text = apodItem?.title
                self.descriptionBox.text = apodItem?.description
                self.image.image = apodItem?.image
            }
        })
    }
    
    func getRandomDate() -> Date{
        var dateComponent = DateComponents()
            dateComponent.day = -Int.random(in: 30...5*365)
        return Calendar.current.date(byAdding: dateComponent, to: self.currentDate)!
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.selectedDate = Calendar.current.date(byAdding: DateComponents(day: 1), to: self.selectedDate)!
        refreshUIElements()
    }
    
    @IBAction func prevButtonPressed(_ sender: Any) {
        self.selectedDate = Calendar.current.date(byAdding: DateComponents(day: -1), to: self.selectedDate)!
        refreshUIElements()
    }
    
}
