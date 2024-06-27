//
//  upangApp.swift
//  upang
//
//  Created by Alvin Miftah on 26/06/24.
//

import SwiftUI
//import SwiftData

@main
struct upangApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
/*
@main
struct upangApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Record.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
}*/
