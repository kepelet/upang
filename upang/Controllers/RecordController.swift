//
//  PersistenceController.swift
//  upang
//
//  Created by Alvin Miftah on 27/06/24.
//

import Foundation
import CoreData

class RecordController {
    static let shared = RecordController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Record")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print("Could not load Record Core Data persistence stores.", error.localizedDescription)
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
                print("Could not save changes to Record Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(){
        
    }
}
