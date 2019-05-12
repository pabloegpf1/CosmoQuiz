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
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        FirebaseAPI.request.signOut { (error) in
            if(error == nil){
                self.performSegue(withIdentifier: "profileToLogin", sender: self)
            }else{
                let alertController = UIAlertController(title: "Error", message: "Please Try Again", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
}
