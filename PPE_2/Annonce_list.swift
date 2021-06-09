//
//  Annonce_list.swift
//  PPE_2
//
//  Created by walid dadi on 11/03/2021.
//

import SwiftUI

struct Annonce_list: View {
    @ObservedObject var store = Get_Annonce()
    @State var viewstat = CGSize.zero
    @State var showCard = false
    @State var active = false
    @State var BottomStat = CGSize.zero
    @State var showFull = false
    @State var show = false
    
    @Binding var ShowProfil : Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    @EnvironmentObject var user : Envi_user
    
    
    var body: some View {
        
        ZStack {
            Color("background2").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack(spacing: 12) {
                        Text("Annonce")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        
                        if user.isLogged{
                            if user.isProprietaire{
                                Bouton_ajt_annonce()
                            }
                        }else{
                            Bouton_ajt_annonce()
                        }
                        
                        AvatarView(ShowProfil: self.$ShowProfil)
                        
                        
                        
                        
                        
                    }
                    .padding(.horizontal)
                    .padding()
                    .padding(.top, 30)
                    .blur(radius: self.active ? 20 : 0 )
                    
                    
                    
                    VStack(spacing: 40) {
                        
                       

                        ForEach(store.post){ post in
                            CoreView(show: $show,
                                     ID_Annonce: post.ID_Annonce,
                                     Titre: post.Titre,
                                     Date_debut: post.Date_debut,
                                     Date_Fin: post.Date_Fin,
                                     prix: post.prix,
                                     ville: post.ville,
                                     Adresse: post.codePostale,
                                     Code_post: post.codePostale,
                                     taille: post.Taille,
                                     nb_piecre: post.nb_pieces
                            )
                            
                        }
                        .offset(y: 20)
                        
                        
                        
                        
                        ZStack {
                            
                            Image(uiImage: #imageLiteral(resourceName: "Background1"))
                            
                        }
                        .animation(.easeIn)
                        .frame(width: 400, alignment: .center)
                        .offset(y: 20)
                        
                    }
                    
                    .frame(width: 400, alignment: .center)
                    .offset(y: 20)
                    
                    
                }
            }
            .offset(y: self.user.showMenu ? -250 : 0)
            .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
            .rotation3DEffect(
                Angle(degrees: self.user.showMenu ? Double(BottomStat.height / 10)-10 : 0),
                axis: (x: 10.0, y: 1.0, z: 0.0))
            .scaleEffect(self.user.showMenu ? 0.9 : 1)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
            
            //            showLogin devien true donc la page connextion s'affiche car l'utilisateur n'est pas connecté
            if self.user.showLogin {
                ZStack {
                    Connexion()
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
                        self.user.showLogin = false
                    }
                }
                
            }
            
            if self.user.showAnnonce {
                ZStack {
                    Add_Annonce()
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
                        self.user.showAnnonce = false
                    }
                }
            }
            if self.user.showMenu{
                MenuView()
                    .offset(y: user.showMenu ? 0 : 30)
                    .animation(.easeIn)
                    .gesture(
                        DragGesture().onChanged { value in
                            self.BottomStat = value.translation
                        }
                        .onEnded {value in
                            if self.BottomStat.height > 50 || self.BottomStat.height < -80 {
                                self.user.showMenu = false
                                self.BottomStat = .zero
                            }else{
                                self.BottomStat = .zero
                            }
                        }
                    )
            }
        }
    }
}



struct Annonce_list_Previews: PreviewProvider {
    static var previews: some View {
        Annonce_list(ShowProfil: .constant(false), showContent: .constant(false)).environmentObject(Envi_user())
        
    }
}





struct CoreView : View {
    @Binding var show : Bool
    @State var viewState = CGSize.zero
    @State var isDragging = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @EnvironmentObject var user : Envi_user
    
    
    var ID_Annonce : String
    var Titre : String
    var Date_debut : String
    var Date_Fin : String
    var prix : String
    var ville : String
    var Adresse : String
    var Code_post : String
    var taille : String
    var nb_piecre : String
    
    
    
    
    
    var body: some View {
        
        
        ZStack {
            
            
            VStack {
                
                
                
                VStack {
                    Image(uiImage: #imageLiteral(resourceName: "image_test"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: show ? 350 : 375, alignment: .top)
                        .offset(y: show ? -50 : -75)
                    
                    
                    
                }
                
                GeometryReader { geometry in
                    Text(Titre)
                        .font(.system(size: geometry.size.width/(show ? 20 : 15) , weight: .bold))
                        .foregroundColor(.white)
                        .animation(.easeIn)
                    
                }
                .frame(maxWidth: 370, maxHeight: 100)
                .padding(.horizontal, 16)
                .offset(y: show ? -40 : -70)
                
                
                ZStack {
                    GeometryReader { geometry in
                        Text("DU : \(Date_debut)")
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x: viewState.width - 10, y: show ? -90 : -100 )
                    
                    GeometryReader { geometry in
                        Text(ville)
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x:viewState.width - 10 , y: show ? -65 : -70 )
                    
                    GeometryReader { geometry in
                        Text("AU : \(Date_Fin)")
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x: viewState.width + 170, y: show ? -90 : -100 )
                    
                    GeometryReader { geometry in
                        Text("\(prix)€ /nuit")
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x:viewState.width + 170 , y:  show ? -65 : -70 )
                    
                    GeometryReader { geometry in
                        Text("\(taille) m²")
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x:viewState.width + 170 , y: show ? -90  : -40)
                    .opacity(show ? 0 : 1)
                    
                    GeometryReader { geometry in
                        Text("\(nb_piecre) Pièces")
                            .font(.system(size: geometry.size.width/18 , weight: .bold))
                            .foregroundColor(.white)
                        
                        
                    }
                    .frame(maxWidth: 375, maxHeight: 100 )
                    .padding(.horizontal, 16)
                    .offset(x:viewState.width - 10 , y: show ? -90  : -40)
                    .opacity(show ? 0 : 1)
                    
                    
                    if self.user.isLogged{
                        if self.user.isProprietaire{
                            
                            
                            
                        }
                        else{
                            HStack {
                                
                                Button(action: {
                                    //si l'utilisateur n'est pas connecté showLogin devien true
                                    
                                    //                                    if !self.user.isLogged{
                                    //                                        self.user.showLogin.toggle()
                                    //                                    }

                                }){
                                    Text("Réserver")
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
                            .offset(x:viewState.width - 20  , y:  show ? -90  : -20)
                            .opacity(show ? 0 : 1)
                            
                        }
                        
                    }else{
                        
                        HStack {
                            
                            Button(action: {
                                //si l'utilisateur n'est pas connecté showLogin devien true
                                
                                if !self.user.isLogged{
                                    self.user.showLogin.toggle()
                                }
                                
                                
                                
                            }){
                                Text("Réserver")
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
                        .offset(x:viewState.width - 20  , y:  show ? -90  : -20)
                        .opacity(show ? 0 : 1)
                    }
                    
                }
                .offset(x: 20)
                
                
                
                
                Spacer()
                
            }
            
            
            
            .multilineTextAlignment(.center)
            .padding(.top, 100)
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
            .frame(height: show ? 280 : 400)
            .frame(width: show ? 350 : 375)
            
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .scaleEffect(isDragging ? 0.9 : 1)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            .rotation3DEffect(
                Angle(degrees: 5),
                axis: (x: viewState.width, y: viewState.height, z: 0)
            )
            
        }
        
        
        
        .onTapGesture {
            self.show.toggle()
            
            
        }
        
        
        
        
    }
}

