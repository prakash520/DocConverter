//
//  DocConverterApp.swift
//  DocConverter
//
//  Created by Prakash Kumar on 05/11/24.
//

import SwiftUI
import SwiftData

@main
struct DocConverterApp: App {
    @Environment(\.scenePhase) var scenePhase
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            // ContentView()
            DocumentView(viewModel: DocumentViewModel())
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        clearTemporaryDirectory()
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
    
    private func clearTemporaryDirectory() {
        let tempDir = FileManager.default.temporaryDirectory
        do {
            let tempFiles = try FileManager.default.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            for file in tempFiles {
                try FileManager.default.removeItem(at: file)
                print("Deleted file at: \(file.path)")
            }
        } catch {
            print("Error clearing temporary directory: \(error)")
        }
    }
}
