//
//  TransactionController.swift
//  upang
//
//  Created by Alvin Miftah on 27/06/24.
//

import Foundation
import CoreData

class TransactionController {
    static let shared = TransactionController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Record")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print("Could not load Transaction Core Data persistence stores.", error.localizedDescription)
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
                print("Could not save changes to Transaction Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(desc: String, category: String, amount: Int64){
        let entity = Transaction(context: container.viewContext)
        
        entity.id = UUID()
        entity.amount = amount
        entity.category = category
        entity.desc = desc
        entity.date = Date()
        
        saveChanges()
    }
    
    func update(entity: Transaction, desc: String? = nil, category: String? = nil, amount: Int64? = nil) {
        // create a temp var to tell if an attribute is changed
        var hasChanges: Bool = false

        // update the attributes if a value is passed into the function
        if desc != nil {
            entity.desc = desc!
            hasChanges = true
        }
        if category != nil {
            entity.category = category!
            hasChanges = true
        }
        if amount != nil {
            entity.amount = amount!
            hasChanges = true
        }

        // save changes if any
        if hasChanges {
            saveChanges()
        }
    }
    
    func read(predicateFormat: String? = nil, fetchLimit: Int? = nil) -> [Transaction] {
        var results: [Transaction] = []
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        
        if predicateFormat != nil {
            request.predicate = NSPredicate(format: predicateFormat!)
        }
        
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        do {
            results = try container.viewContext.fetch(request)
        } catch {
            print("Could not fetch transactions from Core Data.")
        }
        return results
    }
    
    func delete(_ entity: Transaction) {
        container.viewContext.delete(entity)
        saveChanges()
    }
}
