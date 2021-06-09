//
//  Environnement_user.swift
//  PPE_2
//
//  Created by walid dadi on 05/03/2021.
//

import SwiftUI
import Combine


class Envi_user : ObservableObject {
    @Published var isLogged : Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
            
        }
    }
    @Published var isProprietaire : Bool = UserDefaults.standard.bool(forKey: "isProprietaire"){
        didSet {
            UserDefaults.standard.set(self.isProprietaire, forKey: "isProprietaire")
            
        }
    }
    
    @Published var showLogin = false
    @Published var showAnnonce = false
    @Published var showMenu = false
    
    @Published var Nom = ""
    
    @Published var Prenom = ""
   
    @Published var age = ""
    
    @Published var ville = ""
    
    @Published var email = ""

}
