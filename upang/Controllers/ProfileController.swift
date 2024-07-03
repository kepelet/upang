//
//  ProfileController.swift
//  upang
//
//  Created by Alvin Miftah on 28/06/24.
//

import Foundation
import CoreData

class ProfileController {
    static let shared = ProfileController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Record")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error {
                print("Could not load Profile Core Data persistence stores.", error.localizedDescription)
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
                print("Could not save changes to Profile Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(name: String, email: String, age: Int16){
        let entity = Profile(context: container.viewContext)
        
        entity.name = name
        entity.email = email
        entity.age = age
        
        saveChanges()
    }
    
    func update(entity: Profile, name: String? = nil, email: String? = nil, age: Int16? = nil) {
        // create a temp var to tell if an attribute is changed
        var hasChanges: Bool = false

        // update the attributes if a value is passed into the function
        if name != nil {
            entity.name = name!
            hasChanges = true
        }
        if email != nil {
            entity.email = email!
            hasChanges = true
        }
        if age != nil {
            entity.age = age!
            hasChanges = true
        }

        // save changes if any
        if hasChanges {
            saveChanges()
        }
    }
    
    func read(predicateFormat: String? = nil, fetchLimit: Int? = nil) -> [Profile] {
        var results: [Profile] = []
        let request = NSFetchRequest<Profile>(entityName: "Profile")
        
        if predicateFormat != nil {
            request.predicate = NSPredicate(format: predicateFormat!)
        }
        
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        do {
            results = try container.viewContext.fetch(request)
        } catch {
            print("Could not fetch transactions from Profile Core Data.")
        }
        return results
    }
    
    func delete(_ entity: Profile) {
        container.viewContext.delete(entity)
        saveChanges()
    }
}
