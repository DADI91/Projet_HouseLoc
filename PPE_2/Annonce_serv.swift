//
//  Annonce_serv.swift
//  PPE_2
//
//  Created by walid dadi on 11/03/2021.
//

import SwiftUI

import FirebaseFirestore

extension Annonces {
  
    
    static func build(from documents: [QueryDocumentSnapshot]) -> [Annonces]{
        var Post = [Annonces]()
        
        for document in documents {
            Post.append(Annonces(ID_Annonce: document["ID_Annonce"] as? String ?? "",
                                 Titre: document["titre"] as? String ?? "",
                                 Date_debut: document["Date_debut"] as? String ?? "",
                                 Date_Fin: document["Date_Fin"] as? String ?? "",
                                 prix: document["Prix"] as? String ?? "",
                                 ID_logment: document["ID_logment"] as? String ?? ""
                                 

                           
            ))
        }
        return Post
    }

}

extension Logement {


    static func build(from documents: [QueryDocumentSnapshot]) -> [Logement]{
        var Post_L = [Logement]()

        for document in documents {
            Post_L.append(Logement(Logement_ID: document["Logement_ID"] as? String ?? "",
                                   Adresse: document["Adresse"] as? String ?? "",
                                   Ville: document["ville"] as? String ?? "",
                                   CodePostale: document["codePostal"] as? String ?? "",
                                   Taille: document["Taille"] as? String ?? "",
                                   Nb_Pieces: document["nb_pieces"] as? String ?? "",
                                   UserID: document["UserID"] as? String ?? "",
                                   ID_TypeLogement: document["ID_TypeLogement"] as? String ?? ""
            ))


        }
        return Post_L
    }

}
//
//extension type_logment {
//  
//    
//    static func build(from documents: [QueryDocumentSnapshot]) -> [type_logment]{
//        var Post_T = [type_logment]()
//        
//        for document in documents {
//            Post_T.append(type_logment(ID_Type_Logment: document["\(document.documentID)"] as? String ?? "",
//                                       Nom_typeLogement:  document["Nom_typeLogement"] as? String ?? ""
//            ))
//          
//            
//        }
//        return Post_T
//    }
//
//}
//
//
//
//
