//
//  Cardify.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-09-14.
//

import SwiftUI

struct Cardify : ViewModifier, Animatable {
    
    // parameter that sets rotation, no static property of isFaceUp
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // this is a computed property
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 16
        static let lineWidth: CGFloat = 2
    }
}


extension View {
    public func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
