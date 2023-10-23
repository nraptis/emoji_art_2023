//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument
    private let emojis = "😍💩🤡🫵🦫🚨🍎💋👻💀👽🎃🍗🌮⚽️🏀🏈🎾🎮🎰🧩🍕🚕🌷🦷🌵🍔🎂🐻‍❄️🪦"
    private let paletteEmojiSize: CGFloat = 40
    
    var body: some View {
        VStack {
            documentBody
            ScrollingEmojis(emojis: emojis)
                .font(.system(size: paletteEmojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
        
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                ForEach(document.emojis) { emoji in
                    Text(emoji.string)
                        .font(emoji.font)
                        .position(emoji.position.in(geometry))
                }
            }
        }
    }
}



struct ScrollingEmojis: View {
    
    let emojis: [String]
    init(emojis: String) {
        self.emojis = emojis.uniqued.map { String($0) }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
    }
}

#Preview {
    EmojiArtDocumentView(document: .init())
}
