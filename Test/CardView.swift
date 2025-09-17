//
//  CardView.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-09-14.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let insets: CGFloat = 4
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 4
        }
    }
    
    var body: some View {
        // TimelineView is a SwiftUI container that repeatedly invalidates and re-renders its body at intervals you specify
        // in this case, every 1/10 second
        TimelineView(.animation(minimumInterval: 1/10)) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.insets)
                    .cardify(isFaceUp: card.isFaceUp)
                    // .transition(.opacity) - this is the implicit default transition for views
                    // transition describes how a view enters or leaves the view hierarchy
                    .transition(.scale)
            } else {
                // like saying Rectangle().foregroundColor(.clear)
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(3/2, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0 ))
            // independant of other animations and overrides any other explicit animations
            // animates on changes to value
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View {
        CardView(Card(isFaceUp: true, content: "X", id: "test"))
            .padding()
            .foregroundColor(.green)
    }
}


