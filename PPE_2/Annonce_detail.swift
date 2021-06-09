//
//  Annonce_detail.swift
//  PPE_2
//
//  Created by walid dadi on 18/03/2021.
//


import SwiftUI


struct CoursesDetail: View {
    @ObservedObject var store = Get_Annonce()
    @Binding var show : Bool
    @Binding var active : Bool
    @Binding var activeIndex : Int
    @Binding var isScrollable : Bool
    var bounds : GeometryProxy
    
    var body: some View {
        VStack {
            ScrollView{
                Annonce_detail(show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CoursesDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ bounds in
            CoursesDetail(show: .constant(true), active: .constant(true), activeIndex: .constant(-1 ), isScrollable: .constant(true), bounds: bounds )

            
        }
    }
}
 
 

struct Annonce_detail: View {
    @ObservedObject var store = Get_Annonce()
    @Binding var show : Bool
    @Binding var active : Bool
    @Binding var activeIndex : Int
    @Binding var isScrollable : Bool
    var bounds : GeometryProxy
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading , spacing: 8.0) {
                        Text("")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text("course.subtitle")
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                            self.isScrollable = false
                        }
                    }
                }
                Spacer()
                
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
            .frame(maxWidth: show ? .infinity : bounds.size.width - 60)
            .frame(maxHeight: 460)
            .background(Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)))
            .shadow(color: Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)).opacity(0.4) , radius: 20, x: 0, y: 20)
      
        }
    }
}
