//
//  IncomeFormScreenView.swift
//  upang
//
//  Created by Alvin Miftah on 27/06/24.
//

import SwiftUI

struct IncomeFormScreenView: View {
    @State var amount: Int = 0
    @State var description: String = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Text("Amount").font(.headline).foregroundStyle(Color.indigo)
                    TextField("Amount", value: $amount, format: .number, prompt: Text("Insert amount")).textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Text("Description").font(.headline).foregroundStyle(Color.indigo)
                    TextField("Description", text: $description, prompt: Text("Insert description")).textFieldStyle(.roundedBorder)
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
        }.navigationTitle("Add a New Income")
    }
    
    func submit() {
        
    }
}

#Preview {
    IncomeFormScreenView()
}
