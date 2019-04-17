//
//  HomeScreenButton.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 16/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.buttons{
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
        }
    }
    

}
