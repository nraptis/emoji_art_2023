//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    typealias Emoji = EmojiArt.Emoji
    
    private var emojiArt = EmojiArt()
    
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
        .zero
    }
}
