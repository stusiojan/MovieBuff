//
//  MovieBuffApp.swift
//  MovieBuff
//
//  Created by Jan Stusio on 24/03/2023.
//

import SwiftUI

@main
struct MovieBuffApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
