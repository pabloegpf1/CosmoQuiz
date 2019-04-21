//
//  Login.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 21/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func anonLogin(_ sender: Any) {
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        FirebaseAPI.request.login(email: emailField.text!, password: passwordField.text!, completion: { user in
            if(user == nil){
                let alertController = UIAlertController(title: "Error", message: "Please Try Again", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
        })
    }

}
