//
//  HeaderView.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import SwiftUI

struct HeaderView: View {
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
    var body: some View {
        HStack(alignment: .center) {
            Text("Hi, \(profileVM.name)").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            Image(systemName: "person.circle.fill").resizable().frame(width: 30, height: 30)
        }
    }
}

//#Preview {
//    HeaderView()
//}
