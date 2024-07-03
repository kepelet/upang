//
//  BalanceViewModel.swift
//  upang
//
//  Created by Alvin Miftah on 28/06/24.
//

import Foundation

class BalanceViewModel: ObservableObject {
    @Published var balance: Balance?
    
    let dataService = BalanceController.shared
    
    @Published var netBalance: Int64 = 0
    @Published var totalExpense: Int64 = 0
    @Published var totalIncome: Int64 = 0
    
    init(){
        getAllBalance()
    }
    
    func getAllBalance() {
        balance = dataService.read()
        if let balance = balance {
            netBalance = balance.netBalance
            totalIncome = balance.totalIncome
            totalExpense = balance.totalExpense
        }
    }
    
    func createBalance() {
        dataService.create(netBalance: netBalance, totalIncome: totalIncome, totalExpense: totalExpense)
        getAllBalance()
    }
    
    func deleteBalance(balance: Balance) {
        dataService.delete(balance)
        getAllBalance()
    }
    
    func clearState() {
        netBalance = 0
        totalExpense = 0
        totalIncome = 0
    }
}
