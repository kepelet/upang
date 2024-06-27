//
//  HomeScreenView.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var recordViewModel = RecordViewModel()
//    @State private var path = NavigationPath()
//    var recordViewModel: RecordViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Head
                HeaderView(profile: recordViewModel.record.profile)
                // Balance Box
                VStack(alignment: .leading) {
                    VStack(alignment: .leading){
                        Text("Your balance")
                        Text("Rp \(recordViewModel.record.total.netBalance)").font(.largeTitle).fontWeight(.bold)
                    }.foregroundColor(Color(hex: "#023047")).padding(12)
                    HStack(alignment: .center) {
                        Text("Today's expanses : ")
                        Spacer()
                        Text("- Rp \(recordViewModel.record.total.totalExpense)").foregroundStyle(Color.red).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }.padding(12)
                }.frame(height: 150).background(Color.yellow).clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Button
                HStack {
                    NavigationLink(destination: IncomeFormScreenView()) {
                        Label("Add Income", systemImage: "plus.square.fill.on.square.fill")
                            .padding(12)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    Spacer()
                    NavigationLink(destination: IncomeFormScreenView()) {
                        Label("Add Expense", systemImage: "minus.square.fill")
                            .padding(12)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }.padding(.top)
                Spacer()
                
                // History
                VStack(alignment: .leading){
                    Text("History").font(.title).fontWeight(.bold)
                    List(recordViewModel.record.data, id: \.id) { item in
                        HStack {
                            Text(item.description)
                            Spacer()
                            Text("Rp \(item.amount)")
                        }.foregroundColor(item.category == "Expense" ? .red : .blue)
                    }.listStyle(.plain)
                }.padding(.top)
            }.padding().fontDesign(.rounded)
        }
    }
}

//struct HomeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreenView()
//    }
//}
