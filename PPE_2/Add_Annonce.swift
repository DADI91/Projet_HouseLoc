//
//  Add_Annonce.swift
//  PPE_2
//
//  Created by walid dadi on 04/03/2021.
//

import SwiftUI
import Firebase

struct Add_Annonce: View {
    
    
    
    //    var date_formatter : DateFormatter {
    //        let df = DateFormatter()
    //        df.dateStyle = .short
    //        return df
    //    }
    
    /** Annonce*/
    
    @State var ID_annonce = ""
    @State var Titre = ""
    @State var selected_date_debut = ""
    @State var selected_date_fin = ""
    @State var Prix = ""
    
    /** Logement*/
    
    @State var ID_Logement = ""
    @State var Adresse = ""
    @State var ville = ""
    @State var codePostal = ""
    @State var Taille = ""
    @State var nb_pieces = ""
    
    /** Type_logement*/
    
    @State var ID_Type_logement = ""
    @State var type_logement = ""
    @State var selected = 1
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @State var isLoading = false
    @State var isSuccessFull = false
    @EnvironmentObject var user : Envi_user
    @State var db = Firestore.firestore()

    @State var ref_ID_Annonce: DocumentReference? = nil
    @State var ref_Annonce: DocumentReference? = nil
    
    
    func Ajouter_annonce() {
        
        
        
        
        
        
        /** Annonce*/
        
        ref_Annonce = db.collection("Annonce").addDocument(data: [
            "ID_Annonce" : "",
            "titre" : Titre,
            "Date_debut" : selected_date_debut,
            "Date_Fin" : selected_date_fin,
            "Prix" : Prix,
            "Adresse" : Adresse,
            "ville" : ville,
            "codePostal" : codePostal,
            "Taille": Taille,
            "nb_pieces" : nb_pieces,
            "Nom_typeLogement": type_logement,
            "UserID" : Auth.auth().currentUser!.uid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Annonce added with ID: \(ref_Annonce!.documentID)")
                db.collection("Annonce").document(ref_Annonce!.documentID).setData([ "ID_Annonce": ref_Annonce!.documentID ], merge: true)
                
            }
        }
    }
    
    var body: some View {
        
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top) {
                
                
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                
                CoreView_Add_annonce()
                
                ZStack {
                    VStack{
                        ScrollView {
                            
                            /**______________ Annonce_____________*/
                            
                            VStack(spacing: 15) {
                                Text("Annonce")
                                
                                
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color("background1"))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Titre".uppercased(), text: $Titre )
                                        .keyboardType(.default)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    
                                }
                                
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("DU: JJ/MM/YYYY".uppercased(), text: $selected_date_debut )
                                        .keyboardType(.default)
                                        
                                        //                                    DatePicker(selection: $selected_date_debut, in: Date()..., displayedComponents: .date  , label: { Text("Du:").offset(x: 90) })
                                        
                                        
                                        
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    
                                }
                                
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    TextField("AU: JJ/MM/YYYY".uppercased(), text: $selected_date_fin )
                                        //                                    DatePicker(selection: self.$selected_date_fin,                                        in: selected_date_debut...                                                          ,displayedComponents: [.date] , label: {                                            Text("au :").offset(x: 90) })
                                        .keyboardType(.default)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                }
                                
                                HStack {
                                    Image(systemName: "eurosign.circle")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Prix".uppercased(), text: $Prix )
                                        .keyboardType(.numberPad)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                }
                            }
                            
                            
                            /**______________ Logement_____________*/
                            
                            VStack (spacing: 15){
                                
                                Text("Logement")
                                
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color("background1"))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Adresse".uppercased(), text: $Adresse )
                                        .keyboardType(.default)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    
                                }
                                
                                
                                HStack {
                                    Image(systemName: "mappin")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Ville".uppercased(), text: $ville )
                                        .keyboardType(.default)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    
                                }
                                
                                
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Code Postale".uppercased(), text: $codePostal )
                                        .keyboardType(.numberPad)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                            
                                        }
                                }
                                
                                HStack {
                                    Image(systemName: "ruler.fill")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("superficie".uppercased(), text: $Taille)
                                        .keyboardType(.numberPad)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    
                                }
                                
                                
                                
                                HStack {
                                    Image(systemName: "crop.rotate")
                                        .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                        .frame(width: 44, height: 44)
                                        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                        .padding(.leading)
                                    
                                    TextField("Nombre de piéces".uppercased(), text: $nb_pieces )
                                        .keyboardType(.numberPad)
                                        .font(.subheadline)
                                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding(.leading)
                                        .frame(height: 44)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                }
                            }
                            
                            /**______________ Type-Logement_____________*/
                            
                            HStack {
                                
                                VStack(spacing: -60){
                                    Text("Type :")
                                    
                                    Picker(selection: $selected, label: Text("Type Logement")) {
                                        Text("Appartement").tag(1)
                                        Text("Maison").tag(2)
                                        
                                    }
                                    
                                }
                                .padding(.top, 40)
                                
                            }
                            
                            
                            
                            
                            
                            
                            
                        }
                        .padding()
                        .frame(height: 600)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.blur(radius: 3.0))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                        .padding(.horizontal)
                        .offset(y: 460)
                    }
                    
                }
                .offset(y: -350)
                
                
                
                
                
                
                HStack {
                    
                    Button(action: {
                        //self.Login()
                        
                        if selected == 1 {
                            type_logement = "Appartement"
                        }
                        if selected == 2 {
                            type_logement = "Maison"
                        }
                        
                        
                        
                        
                        
                        
                        self.Ajouter_annonce()
                        
                    }){
                        Text("Ajouter")
                            .foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Error "), message: Text(self.alertMessage), dismissButton:  .default(Text("OK")))
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                
                
            }
            //.offset(y: isFocused ? -300 : 0 )
            .animation( .easeInOut )
            .onTapGesture {
                //       self.isFocused = false
                
            }
            
            //            if isLoading {
            //                LoadingView()
            //            }
            
            //            if isSuccessFull {
            //                successView()
            //            }
            
        }
    }
}

struct Add_Annonce_Previews: PreviewProvider {
    static var previews: some View {
        Add_Annonce()
    }
}




struct CoreView_Add_annonce: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                Text("Ajouter votre annonce")
                    
                    .font(.system(size: geometry.size.width/10 , weight: .bold))
                    
                    .foregroundColor(.white)
                    .offset(x: 60, y: -80)
            }
            .frame(maxWidth: 375, maxHeight: 100 )
            .padding(.horizontal, 16)
            .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    //                    .animation(nil)
                    .onAppear { self.show = true
                        
                    }
                
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -260)
                    .rotationEffect(Angle(degrees: show ? 360+90 : 0), anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 100).repeatForever(autoreverses: false))
                //                    .animation(nil)
                
            }
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3.pdf"))
                .offset(x: viewState.width/25, y: viewState.height/25),
            alignment: .bottom)
        
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(
            Angle(degrees: 5),
            axis: (x: viewState.width, y: viewState.height, z: 0)
        )
        
        .gesture(
            DragGesture().onChanged { value in
                self.viewState = value.translation
                self.isDragging = true
            }
            .onEnded { value in
                self.viewState = .zero
                self.isDragging = false
            }
        )
    }
}






