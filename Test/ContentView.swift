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
    @State var isFaceUp: Bool = false
    var body: some View {
        // trailing closure syntax
        ZStack {
            let base = RoundedRectangle(cornerRadius: 16)
            if isFaceUp {
                base.fill(.white)
                base.stroke(lineWidth: 2)
                Text("😁")
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
