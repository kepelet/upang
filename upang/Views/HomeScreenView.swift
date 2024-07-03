//
//  HomeScreenView.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import SwiftUI

struct HomeScreenView: View {
    @ObservedObject var transactionVM: TransactionViewModel = TransactionViewModel()
    @StateObject var balanceVM: BalanceViewModel = BalanceViewModel()
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
//    @State private var path = NavigationPath()
//    var recordViewModel: RecordViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    // Head
                    HeaderView(profileVM: profileVM)
                    // Balance Box
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading){
                            Text("Your balance")
                            Text("Rp \(balanceVM.netBalance)").font(.largeTitle).fontWeight(.bold)
                        }.foregroundColor(Color(hex: "#023047")).padding(12)
                        HStack(alignment: .center) {
                            Text("Today's expanses : ")
                            Spacer()
                            Text("- Rp \(balanceVM.totalExpense)").foregroundStyle(Color.red).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }.padding(12)
                    }.frame(height: 150).background(Color.yellow).clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Button
                    HStack {
                        NavigationLink(destination: TransactionScreenView(defaultCategory: "Income")) {
                            Label("Add Income", systemImage: "plus.square.fill.on.square.fill")
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        Spacer()
                        NavigationLink(destination: TransactionScreenView(defaultCategory: "Expense")) {
                            Label("Add Expense", systemImage: "minus.square.fill")
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }.padding(.top)
                    Spacer()
                    
                    HStack {
                        Text("History").font(.title).fontWeight(.bold).frame(width: .infinity)
                        Spacer()
                    }
                    // History
                    VStack(alignment: .center, spacing: 12){
                        if transactionVM.transactions.count == 0 {
                            Image(systemName: "trash.fill").resizable().frame(width: 50, height: 50)
                            Text("You don't have any transactions yet.").font(.title3)
                        } else {
                            List(transactionVM.transactions, id: \.id) { item in
                                HStack {
                                    Text(String(describing: item.desc!))
                                    Spacer()
                                    Text("Rp \(item.amount)")
                                }.foregroundColor(item.category == "Expense" ? .red : .blue)
                            }.listStyle(.plain)
                        }
                    }.frame(maxWidth: .infinity, minHeight: 400)
                }.padding().fontDesign(.rounded)
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
