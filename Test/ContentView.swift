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
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        })
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 16).fill(.white)
                RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 2)
                Text("😁")
                    .font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 16)
            }
        })
    }
}

#Preview {
    ContentView()
}
