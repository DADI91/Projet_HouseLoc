//
//  Annonce_class.swift
//  PPE_2
//
//  Created by walid dadi on 11/03/2021.
//

import SwiftUI
import FirebaseFirestore

struct Annonces : Codable , Identifiable {
    
    var id = UUID()
    var ID_Annonce : String
    var Titre : String
    var Date_debut : String
    var Date_Fin : String
    var prix : String
    var Adresse : String
    var ville : String
    var codePostale : String
    var Taille : String
    var nb_pieces : String
    var type_logment : String
    var UserID: String




}
    

extension Annonces {
  
    
    static func build(from documents: [QueryDocumentSnapshot]) -> [Annonces]{
        var Post = [Annonces]()
        
        for document in documents {
            Post.append(Annonces(ID_Annonce: document["ID_Annonce"] as? String ?? "",
                                 Titre: document["titre"] as? String ?? "",
                                 Date_debut: document["Date_debut"] as? String ?? "",
                                 Date_Fin: document["Date_Fin"] as? String ?? "",
                                 prix: document["Prix"] as? String ?? "",
                                 Adresse: document["Adresse"] as? String ?? "",
                                 ville: document["ville"] as? String ?? "",
                                 codePostale: document["codePostal"] as? String ?? "",
                                 Taille: document["Taille"] as? String ?? "",
                                 nb_pieces: document["nb_pieces"] as? String ?? "",
                                 type_logment: document["Nom_typeLogement"] as? String ?? "",
                                 UserID: document["UserID"] as? String ?? ""
            ))
        }
        return Post
    }

}

