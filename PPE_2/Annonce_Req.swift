//
//  Annonce_Req.swift
//  PPE_2
//
//  Created by walid dadi on 11/03/2021.
//

import SwiftUI
import FirebaseFirestore
import Firebase




class UserService{
    let database = Firestore.firestore()

    func get_Annonces(collectionID: String, handler: @escaping ([Annonces]) -> Void) {
        database.collection("Annonce")
            .getDocuments() { QuerySnapshot , err in
                if let error = err{ 
                    print(error)
                    handler([])
                } else {
                    
                    
                    handler(Annonces.build(from: QuerySnapshot?.documents ?? []))
                    
                }
        }
        
    }
    
}
