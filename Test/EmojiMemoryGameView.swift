//
//  EmojiMemoryGameView.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-08-05.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    // Purpose: Use an existing ObservableObject that was created elsewhere.
    // When to use: When the object’s lifetime is managed by another view or source.
    // Never ever do - @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    @ObservedObject var viewModel: EmojiMemoryGame
    
    typealias Card = MemoryGame<String>.Card
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let deckWidth: CGFloat = 50
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    
    var body: some View {
        VStack {
            cards.foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundStyle(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            // animates any change that can be animated when the user intent fires
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    // @State not really used in VieWS
    // Primarily used for UI-orientated temporary state that had no effect on model
    @State private var dealt = Set<Card.ID>()
    
    private func isDealth(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        // $0 is card id
        return viewModel.cards.filter { !isDealth($0) }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealth(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    // .transition(.identity) means no transition at all, not matchedGeometryEffect, nothing
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
//                    .transition(.offset(
//                        x: CGFloat.random(in: -1000...1000),
//                        y: CGFloat.random(in: -1000...1000)
//                    ))
            }
        }
    }
    
    // this is of type Namespace
    @Namespace private var dealingNamespace
    
    private var deck : some View  {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth/aspectRatio)
        .onTapGesture {
           deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                // give me the return and put it nowhere
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        // animates any change that can be animated when the user intent fires
        withAnimation(.easeInOut(duration: 1)) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return id == card.id ? amount : 0
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
