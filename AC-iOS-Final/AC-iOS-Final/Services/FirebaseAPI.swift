//
//  FirebaseAPI.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

enum AppError: Error {
    case invalidChildren
    
}


class FirebaseAPIClient {
    private init() {}
    static let manager = FirebaseAPIClient()
    
    func createAccount (with email: String, and password: String, completion: @escaping AuthResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        
    }
    func login (with email: String, an password: String, completion: @escaping (User?, Error?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func logOutCurrentUser() {
        do {
            try Auth.auth().signOut()
            
        }
            
        catch {
            print(error)
        }
    }
    
    
}

