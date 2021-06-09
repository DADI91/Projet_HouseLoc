//
//  Annonce_Get_data.swift
//  PPE_2
//
//  Created by walid dadi on 11/03/2021.
//

import SwiftUI
import Combine

class Get_Annonce : ObservableObject {
    @Published var  post : [Annonces] = []

    init() {
        
        getposte()
    }
    
    func getposte(){
        
        var index = 0
        
        UserService().get_Annonces(collectionID: "Annonce") { (posts) in
            self.post = posts
            index = index + 1
        }
        
    }
     
}
