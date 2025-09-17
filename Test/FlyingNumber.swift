//
//  FlyingNumber.swift
//  Test
//
//  Created by Saboor Bakshi on 2025-09-15.
//

import SwiftUI

struct FlyingNumber: View {
    var number: Int
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .opacity(offset != 0 ? 0 : 1)
                .offset(x: 0, y: offset)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear {
                    // no animatin here whatsoever
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 4)
}
