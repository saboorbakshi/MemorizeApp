//
//  TestApp.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-08-05.
//

import SwiftUI

@main
struct TestApp: App {
    // We need to have @StateObject somewhere, app level or lower
    // Purpose: Tell a view to create and own an ObservableObject
    // i.e. EmojiMemoryGame in this case
    // When to use: When the view itself should create and keep the object alive.
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        } 
    }
}
