//
//  Connexion.swift
//  PPE_2
//
//  Created by walid dadi on 03/03/2021.
//

import SwiftUI
import Firebase

struct Connexion: View {
    
    @State var email = ""
    @State var password = ""
    
    
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @State var isLoading = false
    @State var isSuccessFull = false
    @State var show_inscrip = false
    @EnvironmentObject var user : Envi_user
    
    @State var db = Firestore.firestore()
    @State var ref : DocumentReference? = nil
    @ObservedObject var userSettings = Envi_user()
    
    
    
    func Connexion_User(){
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                self.isSuccessFull = true
                self.user.isLogged = true
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccessFull = false
                    self.user.showLogin = false
                    self.user.ville = email
                    
                    
                }
                
                let User = Auth.auth().currentUser
                
                
                
                print("\(user.isLogged)")
                
                
                db.collection("Utilisateur").whereField("userID", isEqualTo: User!.uid)
                    .getDocuments() { querySnapshot , err in
                        if let error = err{
                            print(error)
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(String(describing: document.get("email")!)) => \(String(describing: document.get("userID")!)) => \(String(describing: document.get("type_utilisateur")!))")
                                
                                self.user.email = "\(String(describing: document.get("email")!))"
                                self.user.Nom = "\(String(describing: document.get("nom")!))"
                                self.user.Prenom = "\(String(describing: document.get("prenom")!))"
                                self.user.age = "\(String(describing: document.get("age")!))"
                                self.user.ville = "\(String(describing: document.get("ville")!))"
                                
                                
                                let TYPE = document.get("type_utilisateur")
                                
                                if TYPE! as! String == "Proprietaire"{
                                    self.user.isProprietaire = true
                                }
                                if TYPE! as! String == "Locataire"{
                                    self.user.isProprietaire = false
                                }
                                
                                print(self.user.isProprietaire)
                                
                            }
                        }
                        
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
                
                
                CoreView_Connexion()
                
                ZStack {
                    VStack(spacing: 15) {
                   
                        VStack {
                            
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                    .frame(width: 44, height: 44)
                                    .background(Color("background1"))
                                    .clipShape(RoundedRectangle(cornerRadius: 16  , style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5 )
                                    .padding(.leading)
                                
                                TextField("Email".uppercased(), text: $email)
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
                            
                            
                        }
                        .padding()
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.blur(radius: 3.0))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                        .padding(.horizontal)
                        .offset(y: 460)
                        
                        
                        
                        
                    }
                    .offset(y: -350)
                    
                    
                    VStack{
                        
                        VStack {
                            Text("Vous n'avez pas de compte ?")
                        }
                        
                        VStack {
                            Text("Inscrivez-vous")
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    
                                    self.show_inscrip.toggle()
                                       
                                }
                        }
                        
                    }
                    .offset(y: 220.0)
                    
                    HStack {
                        
                        Button(action: {
                            //self.Login()
                            
                            self.Connexion_User()
                            
                            //                            self.Inscription()
                            //                            self.addUser()
                            
                        }){
                            Text("Connexion")
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
                    //.offset(y: isFocused ? -300 : 0 )
                    
                    
                    
                    
                    
                }
                
                
                
                .animation( .easeInOut )
                .onTapGesture {
                    self.isFocused = false
                    
                }
                
                
              
                
                //            if isLoading {
                //                LoadingView()
                //            }
                
                //            if isSuccessFull {
                //                successView()
                //            }
                
            }
            
            if self.show_inscrip {
                ZStack {
                    Inscription()
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        self.show_inscrip = false
                    }
                }
            }
 
        }
    }
}

struct Connexion_Previews: PreviewProvider {
    static var previews: some View {
        Connexion()
    }
}




struct CoreView_Connexion: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    var body: some View {
        VStack {
            
            GeometryReader { geometry in
                Text("Connexion")
                    
                    .font(.system(size: geometry.size.width/10 , weight: .bold))
                    
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100 )
            .padding(.horizontal, 16)
            .offset(x: viewState.width/20, y: viewState.height/20)
            
            
            
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 430)
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

