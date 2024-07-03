//
//  BalanceController.swift
//  upang
//
//  Created by Alvin Miftah on 28/06/24.
//

import Foundation
import CoreData

class BalanceController {
    static let shared = BalanceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Record")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print("Could not load Balance Core Data persistence stores.", error.localizedDescription)
                fatalError()
            }
        }
    }
    
    func saveChanges() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Could not save changes to Balance Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(netBalance: Int64, totalIncome: Int64, totalExpense: Int64){
        let entity = Balance(context: container.viewContext)
        
        entity.netBalance = netBalance
        entity.totalIncome = totalIncome
        entity.totalExpense = totalExpense
        
        saveChanges()
    }
    
    func update(entity: Balance, netBalance: Int64? = nil, totalIncome: Int64? = nil, totalExpense: Int64? = nil) {
        // create a temp var to tell if an attribute is changed
        var hasChanges: Bool = false

        // update the attributes if a value is passed into the function
        if netBalance != nil {
            entity.netBalance = netBalance!
            hasChanges = true
        }
        if totalIncome != nil {
            entity.totalIncome = totalIncome!
            hasChanges = true
        }
        if totalExpense != nil {
            entity.totalExpense = totalExpense!
            hasChanges = true
        }

        // save changes if any
        if hasChanges {
            saveChanges()
        }
    }
    
    func read(predicateFormat: String? = nil) -> Balance? {
        let request = NSFetchRequest<Balance>(entityName: "Balance")
        
        if let predicateFormat = predicateFormat {
            request.predicate = NSPredicate(format: predicateFormat)
        }
        
        request.fetchLimit = 1
        
        do {
            let results = try container.viewContext.fetch(request)
            return results.first
        } catch {
            print("Could not fetch balance from Balance Core Data.")
            return nil
        }
    }
    
    func delete(_ entity: Balance) {
        container.viewContext.delete(entity)
        saveChanges()
    }
}
