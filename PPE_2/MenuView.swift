//
//  MenuView.swift
//  PPE_2
//
//  Created by walid dadi on 23/03/2021.
//
//
//  MenuView.swift
//  DesigneCode
//
//  Created by walid dadi on 11/02/2021.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @EnvironmentObject var user : Envi_user
    
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16){
                Text(self.user.email)
                
                MenuRow(titre: "Déconnexion ", icon: "person.crop.circle")
                    .onTapGesture {
                        UserDefaults.standard.set(false , forKey: "isLogged")
                        self.user.isLogged = false
                        self.user.showAnnonce = false
                        self.user.showMenu = false
                    }
            }
            .frame(maxWidth: 300)
            .frame(maxHeight: 100)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal)
        }
        .padding(.bottom, 20)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(Envi_user())
    }
}

struct MenuRow: View {
    var titre: String
    var icon: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32 )
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.8549019608, alpha: 1)))
            
            
            Text(titre)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 150, alignment: .leading)
        }
    }
}
