//
//  Posts.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

struct Post {
    let ref: DatabaseReference
    let postId: String
    let userId: String
    let comment: String
    let imageURL: String
    
    
 
    init(ref: DatabaseReference,
         user: String, comment: String,
         imageURL: String){
        
        self.ref = ref
        self.postId = ref.key
        self.userId = user
        self.comment = comment
        self.imageURL = imageURL
    }
    
    // take info from firebase
    
    init(snapShot: DataSnapshot){
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.postId = snapShot.ref.key
        self.userId = value?["userId"] as? String ?? ""
        self.comment = value?["comment"] as? String ?? ""
        self.imageURL = value?["imageURL"] as? String ?? ""
    }
    
    
    // transform info previous to save
    func toAnyObject() -> [String: Any] {
        return ["postId" : postId, "userId": userId,
                "comment" : comment, "imageURL": imageURL]
    }
}
