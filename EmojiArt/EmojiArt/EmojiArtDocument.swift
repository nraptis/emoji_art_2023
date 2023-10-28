//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL), let autosavedEmojiArt = try? EmojiArt(json: data) {
            emojiArt = autosavedEmojiArt
            
        }
    }
    
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt() {
        didSet {
            autosave()
            if emojiArt.background != oldValue.background {
                Task {
                    await fetchBackgroundImage()
                }
            }
        }
    }
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.emojiart")
    
    private func autosave() {
        save(to: autosaveURL)
        print("auto saved to \(autosaveURL.absoluteString)")
    }
    
    private func save(to url: URL) {
        do {
            let data = try emojiArt.json()
            try data.write(to: url)
        } catch {
            print("EmojiArtDocument: error while saving : \(error.localizedDescription)")
        }
    }
    
    
    var emojis: [Emoji] {
        emojiArt.emojis
    }
    
    @Published var background: Background = .none
    
    // MARK: - Background Image
    
    @MainActor private func fetchBackgroundImage() async {
        
        if let url = emojiArt.background {
            background = .fetching(url)
            do {
                let image = try await fetchUIImage(from: url)
                if url == emojiArt.background {
                    background = .found(image) // or ...
                }
            } catch {
                background = .failed("Couldn't set background: \(error.localizedDescription)")
            }
            
        } else {
            background = .none
        }
    }
    
    var boundingBox: CGRect {
        var result = CGRect.zero
        for emoji in emojis {
            result = result.union(emoji.boundingBox)
        }
        if let backgroundSize = background.uiImage?.size {
            result = result.union(CGRect(center: .zero, size: backgroundSize))
        }
        return result
    }
    
    private func fetchUIImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            throw FetchError.badImageData
        }
    }
    
    enum FetchError: Error {
        case badImageData
    }
    
    enum Background {
        case none
        case fetching(URL)
        case found(UIImage)
        case failed(String)
        
        var uiImage: UIImage? {
            switch self {
            case .found(let uiImage): return uiImage
            default: return nil
            }
        }
        
        var urlBeingFetched: URL? {
            switch self {
            case .fetching(let url): return url
            default: return nil
            }
        }
        
        var isFetching: Bool { urlBeingFetched != nil }
        
        var failureReason: String? {
            switch self {
            case .failed(let reason): return reason
            default: return nil
            }
        }
        
        
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

extension EmojiArt.Emoji {
    var boundingBox: CGRect {
        CGRect(center: position.in(nil),
               size: CGSize(width: CGFloat(size),
                            height: CGFloat(size)))
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy?) -> CGPoint {
        let center = geometry?.frame(in: .local).center ?? .zero
        return CGPoint(x: center.x + CGFloat(x),
                       y: center.y - CGFloat(y))
    }
}
