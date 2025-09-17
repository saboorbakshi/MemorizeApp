//
//  EmojiMemoryGame.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-08-08.
//

// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["☠️", "👻", "🎃", "🕷️", "👹", "🍭", "🍬", "🍡"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 10) { (pairIndex) in
            if emojis.indices.contains(pairIndex) {
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
         
    @Published private var model = createMemoryGame()
    
    typealias Card = MemoryGame<String>.Card
    
    var cards: [Card] {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    // MARK:  - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}


