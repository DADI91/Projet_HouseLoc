//
//  TapBar.swift
//  PPE_2
//
//  Created by walid dadi on 05/03/2021.
//

import SwiftUI

struct TapBar: View {

    var body: some View {
        TabView {

            Annonce_list(ShowProfil: .constant(false), showContent: .constant(false)).tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Annonce")
            }

        }

    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar().environmentObject(Envi_user())
    }
}
