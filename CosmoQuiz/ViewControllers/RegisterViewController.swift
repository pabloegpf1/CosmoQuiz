//
//  Register.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 19/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordCheck: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if(firstname.text != "" && email.text != "" && password.text != "" && passwordCheck.text != ""){
            FirebaseAPI.request.register(displayname: firstname.text!, email: email.text!, password: password.text!, completion: { user in
                    if(user == nil){
                        let alertController = UIAlertController(title: "Error", message: "Please Try Again", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        self.performSegue(withIdentifier: "registerToHome", sender: self)
                    }
            })
        }else{
            let alert = UIAlertController(title: "Error", message: "Please fill up all the information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
            
    }
    
}
