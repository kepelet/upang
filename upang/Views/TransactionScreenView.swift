//
//  TransactionScreenView.swift
//  upang
//
//  Created by Alvin Miftah on 27/06/24.
//

import SwiftUI

struct TransactionScreenView: View {
    @StateObject var transactionVM: TransactionViewModel = TransactionViewModel()
    @State private var backToHomeScreen = false
    var defaultCategory = ""
    let categories = ["Income", "Expense"]
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Text("Amount").font(.headline).foregroundStyle(Color.indigo)
                    TextField("Amount", value: $transactionVM.amount, format: .number, prompt: Text("Insert amount")).textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Text("Description").font(.headline).foregroundStyle(Color.indigo)
                    TextField("Description", text: $transactionVM.desc, prompt: Text("Insert description")).textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Picker("Select category", selection: $transactionVM.category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }.textFieldStyle(.roundedBorder).foregroundColor(.indigo).font(.headline)
                }
            }
            VStack {
                Button(action: submit) {
                    Text("Submit").frame(maxWidth: .infinity)
                }.padding(12)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }.padding()
        }.navigationTitle("Add a New Transaction").navigationDestination(isPresented: $backToHomeScreen){
            HomeScreenView()
        }.onAppear {
            transactionVM.category = defaultCategory
        }
    }
    
    func submit() {
        transactionVM.createTransaction()
        transactionVM.clearState()
        backToHomeScreen = true
    }
}

#Preview {
    TransactionScreenView()
}
