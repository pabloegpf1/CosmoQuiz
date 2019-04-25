//
//  FirebaseAPI.swift
//  CosmoQuiz
//
//  Created by Pablo Escriva on 19/04/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//

import Firebase
import FirebaseDatabase
import FirebaseAuth

struct FirebaseAPI{
    
    static let request = FirebaseAPI()
    
    func register(displayname:String,email:String,password:String, completion: @escaping (AuthDataResult?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
            if error == nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = "\(displayname)"
                changeRequest?.commitChanges { error in
                    completion(nil)
                }
                completion(user)
            }else{
                completion(nil)
            }
        }
    }
    
    func login(email:String,password:String,completion: @escaping (AuthDataResult?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                completion(user)
            }else{
                completion(nil)
            }
        }
    }
    
    func loginAnonimously(completion: @escaping (AuthDataResult?) -> ()){
        Auth.auth().signInAnonymously() { (authResult, error) in
            if error == nil{
                completion(authResult)
            }else{
                completion(nil)
            }
        }
    }
    
    func signOut(completion: @escaping (Error?) -> ()){
        do {
            try Auth.auth().signOut()
        } catch (let error) {
            completion(error)
        }
        completion(nil)
    }

}

