//
//  HomeView.swift
//  PPE_2
//
//  Created by walid dadi on 22/03/2021.
//

import SwiftUI

struct HomeView: View {
    @Binding var ShowProfil : Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    
    var body: some View {
        HStack(spacing: 12) {
            Text("Watching")
                .font(.system(size: 28, weight: .bold))
            
            Spacer()
            
            Bouton_ajt_annonce()
            
            AvatarView(ShowProfil: self.$ShowProfil)
            
            
            


            
            
        }
        .padding(.horizontal)
        .padding()
        .padding(.top, 30)
        .blur(radius: self.active ? 20 : 0 )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(ShowProfil: .constant(false), showContent: .constant(false)).environmentObject(Envi_user())
    }
}


struct AvatarView: View {
    @Binding var ShowProfil : Bool
    @EnvironmentObject var user :  Envi_user
    
    var body: some View {
        VStack {
            if user.isLogged  {
                Button(action: {self.user.showMenu.toggle()}) {
                Image(systemName: "lock.open")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2 ), radius: 4, x: 0, y: 1)

                }
            } else {
                Button(action: {self.user.showLogin.toggle()}) {
                Image(systemName: "lock")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2 ), radius: 4, x: 0, y: 1)
                }
            }
        }
    }
}

struct Bouton_ajt_annonce: View {
    @EnvironmentObject var user :  Envi_user
    
    var body: some View {
        VStack {
            if user.isLogged  {
                Button(action: {self.user.showAnnonce.toggle()}) {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2 ), radius: 4, x: 0, y: 1)

                }
            } else {
                Button(action: {self.user.showLogin.toggle()}) {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 36, height: 36)
                    .background(Color("background3"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2 ), radius: 4, x: 0, y: 1)
                }
            }

            
        }
    }
}
