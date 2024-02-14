//
//  MainApp.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

@main
struct MainApp: App {
    
    @ObservedObject var manager = PokemonDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    manager.setup()
                }
                .environmentObject(manager)
        }
    }
}
