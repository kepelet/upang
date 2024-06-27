//
//  RecordViewModel.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import Foundation
//import SwiftData

// With SwiftData
/*
extension ContentView {
    @Observable
    class RecordViewModel {
        var modelContext: ModelContext
//        var record = Record()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            load()
        }
        
        func load() {
            let container = try result.get()
            let data: Data
            let filename = "records.json"
            
            let descriptor = FetchDescriptor<Record>()
            let existingRecord = try container.mainContext.fetchCount(descriptor)
            guard existingRecord == 0 else { return }
            
            guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
                fatalError("Couldn't find \(filename) in main bundle.")
            }
            
            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
            }
            
            do {
                let decoder = JSONDecoder()
                let record = try decoder.decode(Record.self, from: data)
                container.mainContext.insert(record)
            } catch {
                fatalError("Couldn't parse \(filename) as \(Record.self):\n\(error)")
            }
        }
        
//        func insertIncome(data: Transaction) {
//            let record = Record()
//        }
    }
}
 */

// Without SwiftData

public class RecordViewModel: ObservableObject {
    @Published var record: Record
    
    init() {
        self.record = RecordViewModel.load()
    }
    
    static func load() -> Record {
        let data: Data
        let filename = "records.json"
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Record.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Record.self):\n\(error)")
        }
    }
}
