//
//  TransactionViewModel.swift
//  upang
//
//  Created by Alvin Miftah on 28/06/24.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var balance: Balance?
    
    let dataService = TransactionController.shared
    let balanceService = BalanceController.shared
    
    @Published var desc: String = ""
    @Published var amount: Int64 = 0
    @Published var category: String = ""
    
    init(){
        getAllTransaction()
        getBalance()
    }
    
    func getBalance(){
        balance = balanceService.read()
    }
    
    func getAllTransaction() {
        transactions = dataService.read()
    }
    
    func addIncome() {
        if let balance = balance {
            let totalIncome = balance.totalIncome + amount
            let netBalance = balance.netBalance + amount
            let totalExpense = balance.totalExpense
            balanceService.update(entity: balance, netBalance: netBalance, totalIncome: totalIncome, totalExpense: totalExpense)
        } else {
            balanceService.create(netBalance: amount, totalIncome: 0, totalExpense: amount)
        }
    }
    
    func addExpense() {
        if let balance = balance {
            let totalExpense = balance.totalExpense + amount
            let netBalance = balance.netBalance - amount
            let totalIncome = balance.totalIncome
            balanceService.update(entity: balance, netBalance: netBalance, totalIncome: totalIncome, totalExpense: totalExpense)
        } else {
            balanceService.create(netBalance: amount, totalIncome: amount, totalExpense: 0)
        }
    }
    
    func createTransaction() {
        dataService.create(desc: desc, category: category, amount: amount)
        if(category == "Income"){
            addIncome()
        } else {
            addExpense()
        }
        
        getAllTransaction()
    }
    
    func deleteTransaction(transaction: Transaction) {
        dataService.delete(transaction)
        getAllTransaction()
    }
    
    func clearState() {
        desc = ""
        amount = 0
        category = ""
    }
}
