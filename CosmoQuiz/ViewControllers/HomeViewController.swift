//
//  HomeScreenButton.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 16/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        for button in self.buttons{
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        // TO DO: SIGN OUT
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
    }
    
}
