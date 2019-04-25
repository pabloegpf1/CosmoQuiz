//
//  ApodViewController.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 23/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class ApodViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var descriptionBox: UITextView!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in self.buttons{
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
        }
    }

}
