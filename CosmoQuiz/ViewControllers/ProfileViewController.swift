//
//  Profile.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 21/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = Auth.auth().currentUser?.displayName
        emailLabel.text = Auth.auth().currentUser?.email
    }
    
    
    
}
