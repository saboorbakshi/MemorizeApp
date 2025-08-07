//
//  ContentView.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-08-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(content: {
            let emojis: [String] = ["☠️", "👻", "🎃", "🕷️", "👹"]
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        })
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    
    var body: some View {
        // trailing closure syntax
        ZStack {
            let base = RoundedRectangle(cornerRadius: 16)
            if isFaceUp {
                base.fill(.white)
                base.stroke(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            else {
                base
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
