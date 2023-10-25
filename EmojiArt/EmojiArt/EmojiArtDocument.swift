//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    
    init() {
        emojiArt.addEmoji("🏆", at: .init(x: -100, y: 100), size: 40)
        emojiArt.addEmoji("🥨", at: .init(x: 250, y: 100), size: 80)
        emojiArt.addEmoji("⛄️", at: .init(x: -50, y: -200), size: 120)
        
    }
    
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt()
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK - Intent(s)
    
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji,
                          at: position,
                          size: Int(size))
    }
    
}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x),
                       y: center.y - CGFloat(y))
    }
}
