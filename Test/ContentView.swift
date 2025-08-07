//
//  ContentView.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-08-05.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount = 4
    let emojis: [String] = ["☠️", "👻", "🎃", "🕷️", "👹", "🍭", "🍬", "🍡"]
    
    var body: some View {
        VStack() {
            ScrollView {
                cards
            }
            // Spacer takes the maximum possible space!
            Spacer()
            cardAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, symbol: "minus.circle")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "plus.circle")
            
        }
        .imageScale(.large)
        .font(.title2)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    
    var body: some View {
        // trailing closure syntax
        ZStack {
            let base = RoundedRectangle(cornerRadius: 16)
            Group {
                base.fill(.white)
                base.stroke(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
