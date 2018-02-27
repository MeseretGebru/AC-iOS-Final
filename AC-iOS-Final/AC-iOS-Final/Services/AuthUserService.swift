//
//  AuthUserService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import Firebase

@objc protocol AuthUserServiceDelegate: class {
    // create user delegate protocols
    @objc optional func didFailCreatingUser(_ userService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ userService: AuthUserService, user: User)
    
    // sign out delegate protocols
    @objc optional func didFailSigningOut(_ userService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ userService: AuthUserService)
    
    // sign in delegate protocols
    @objc optional func didFailToSignIn(_ userService: AuthUserService, error: Error)
    @objc optional func didFailToEmailVerify()
    @objc optional func didSignIn(_ userService: AuthUserService, user: User)
}

class AuthUserService: NSObject {
    weak var delegate: AuthUserServiceDelegate?
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                
                // update Authentication user displayName with their email prefix
                let changeRequest = user.createProfileChangeRequest()
                let stringArray = user.email!.components(separatedBy: "@")
                let username = stringArray[0]
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("changeRequest error: \(error)")
                    } else {
                        print("changeRequest was successful for username: \(username)")
                        // add the authenticated user to the database
                        user.sendEmailVerification(completion: { (error) in
                            if let error = error {
                                print("Error ocurred while sending email:", error)
                            }
                        })
                        self.delegate?.didCreateUser?(self, user: user)
                    }
                })
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailToSignIn?(self, error: error)
            } else if let user = user {
                if !user.isEmailVerified {
                    self.delegate?.didFailToEmailVerify?()
                } else {
                    self.delegate?.didSignIn?(self, user: user)
                }
            }
        }
    }
}
