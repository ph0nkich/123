//
//  ContentView.swift
//  memorize
//
//  Created by Кирилл on 30.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = ["☠️", "👹", "🎃", "🧙‍♀️", "☠️", "👹", "🎃", "🧙‍♀️"]
    
    @State var cardCount: Int = 8
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            HStack {
                VStack {
                    halloweenCard
                        .font(.largeTitle)
                    Text("Halloween")
                        .font(.caption)
                }
                Spacer()
                VStack {
                    sportCard
                        .font(.largeTitle)
                    Text("Sport")
                        .font(.caption)
                }
                Spacer()
                VStack {
                    vehiclesCard
                        .font(.largeTitle)
                    Text("Vehicles")
                        .font(.caption)
                }
            }
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
        .foregroundStyle(.red)
    }
    
    func newEmojis(_ new: [String]) {
        let pairs = new + new
        let shufflerPairs = pairs.shuffled()
        emojis = shufflerPairs
        cardCount = shufflerPairs.count
    }
    
    func theme(wantedEmojis: [String], symbol: String) -> some View {
        Button(action: {
            newEmojis(wantedEmojis)
        }, label: {
            Image(systemName: symbol)
        })
    }
    
    var halloweenCard: some View {
        let halloweenArray: [String] = ["☠️", "👹", "🎃", "🧙‍♀️"]
        return theme(wantedEmojis: halloweenArray, symbol: "moon.stars")
    }
    
    var sportCard: some View {
        let sportArray: [String] = ["⚽️", "🏀", "🏈", "🎱"]
        return theme(wantedEmojis: sportArray, symbol: "figure.walk")
    }
    
    var vehiclesCard: some View {
        let vehiclesArray: [String] = ["🚕", "🚑", "🚓", "🏎️"]
        return theme(wantedEmojis: vehiclesArray, symbol: "car")
    }
}
struct CardView: View {
    var content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundStyle(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
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
