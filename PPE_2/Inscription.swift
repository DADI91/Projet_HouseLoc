//
//  Inscription.swift
//  PPE_2
//
//  Created by walid dadi on 28/02/2021.
//

import SwiftUI
import Firebase



struct Inscription: View {
    @State var userID = ""
    @State var nom = ""
    @State var prenom = ""
    @State var age = ""
    @State var ville = ""
    @State var type_utilisateur = ""
    @State var email = ""
    @State var password = ""
    
    @State var selected = 1
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @State var isLoading = false
    @State var isSuccessFull = false
    @EnvironmentObject var user : Envi_user
    
    @State var db = Firestore.firestore()
    @State var ref : DocumentReference? = nil
    
    func Inscription() {
        
        
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                self.isSuccessFull = true
                self.user.isLogged = true
                self.user.Nom = nom
                self.user.Prenom = prenom
                self.user.age = age
                self.user.email = ville
                self.user.ville = email
                
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccessFull = false
                    self.user.showLogin = false
                    
                    
                    
                }
                
                
                
                
                
                
                
                let User = Auth.auth().currentUser
                
                ref = db.collection("Utilisateur").addDocument(data: [
                    "userID": User!.uid,
                    "nom": nom,
                    "prenom": prenom,
                    "age": age,
                    "ville": ville,
                    "type_utilisateur": type_utilisateur,
                    "email": email
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        print("user added with ID: \(User!.uid)")
                    }
                }
                
                if self.type_utilisateur == "Proprietaire" {
                    self.user.isProprietaire = true
                }
                else if self.type_utilisateur == "Locataire"{
                    self.user.isProprietaire = false
                }
                
                
            
                
                
        
                
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
                
                
                CoreView_Inscription()
                
                ZStack {
                    
                    VStack(spacing: 10){
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            TextField("Nom".uppercased(), text: $nom)
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
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            TextField("Prenom".uppercased(), text: $prenom)
                                .keyboardType(.emailAddress)
                                .font(.subheadline)
                                //.textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading)
                                .frame(height: 44)
                                .onTapGesture {
                                    self.isFocused = true
                                }
                            
                        }
                        
                        
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            TextField("age".uppercased(), text: $age)
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
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            TextField("ville".uppercased(), text: $ville)
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
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            TextField("Email".uppercased(), text: $email)
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
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                .frame(width: 44, height: 44)
                                .background(Color("background1"))
                                .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                .padding(.leading)
                            
                            SecureField("Mot de passe".uppercased(), text: $password)
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
                            
                            VStack(spacing: -60){
                                Text("Type :")
                                
                                Picker(selection: $selected, label: Text("Type Utilisateur")) {
                                    Text("Proprietaire").tag(1)
                                    Text("Locataire").tag(2)
                                    
                                }
                                
                            }
                            .padding(.top, 40)
                            
                        }
                        
                    }
                    .padding(10)
                    .offset(y: 20)
                    .frame(height: 550)
                    .frame(maxWidth: .infinity)
                    .background(Color.white.blur(radius: 3.0))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                    .padding(.horizontal)
                    .offset(y: 460)
                    
                    
                }
                .offset(y: -350)
                
                
                
                
                
                
                HStack {
                    
                    Button(action: {
                        //self.Login()
                        
                        
                        if selected == 1 {
                            type_utilisateur = "Proprietaire"
                        }
                        if selected == 2 {
                            type_utilisateur = "Locataire"
                        }
                        
                        self.Inscription()
                        //self.addUser()
                        
                    }){
                        Text("S'inscrire")
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
                .offset(y: -10)

                
            }
            //.offset(y: 0 )
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

struct Inscription_Previews: PreviewProvider {
    static var previews: some View {
        Inscription()
    }
}




struct CoreView_Inscription: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                Text("Inscription")
                    
                    .font(.system(size: geometry.size.width/10 , weight: .bold))
                    
                    .foregroundColor(.white)
            }
            .offset(y: -50)
            .frame(maxWidth: 375, maxHeight: 100 )
            .padding(.horizontal, 16)
            .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 350)
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
                //                self.viewState = value.translation
                //                self.isDragging = true
            }
            .onEnded { value in
                //                self.viewState = .zero
                //                self.isDragging = false
            }
        )
    }
}

