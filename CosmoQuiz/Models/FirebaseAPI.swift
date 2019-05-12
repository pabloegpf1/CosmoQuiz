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

var db: DatabaseReference!

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
    
    func getTotalPoints(completion: @escaping (Int?) -> ()){
        var score = 0
        db.child("LeaderBoard").child(Auth.auth().currentUser!.uid)
            .observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                score = value?["Score"] as? Int ?? 0
                print("Previous points = \(score)")
                completion(score)
            }){ (error) in
                print(error.localizedDescription)
                completion(nil)
        }
    }
    
    func saveScore(score:Int, completion: @escaping (Error?) -> ()){
        getTotalPoints { (points) in
            db.child("LeaderBoard/").child(Auth.auth().currentUser!.uid)
                .setValue([
                    "Player": Auth.auth().currentUser?.displayName ?? "Anonimous\(Int.random(in: 0..<1000))",
                    "Score": points!+score
                ]){(error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        completion(error)
                    } else {
                        print("Data saved successfully!")
                        print("New points = \(points!+score)")
                        completion(nil)
                    }
            }
        }
    }
    

}

