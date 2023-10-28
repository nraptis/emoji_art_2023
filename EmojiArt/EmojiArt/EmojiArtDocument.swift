//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let emojiArt = UTType(exportedAs: "edu.nick.raptis.emojiart")
}

class EmojiArtDocument: ReferenceFileDocument {
    
    static var readableContentTypes: [UTType] {
        [.emojiArt]
    }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            emojiArt = try EmojiArt(json: data)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func snapshot(contentType: UTType) throws -> Data {
        try emojiArt.json()
    }
    
    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        FileWrapper(regularFileWithContents: snapshot)
    }
    
    init() {
        
    }
    
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt() {
        didSet {
            if emojiArt.background != oldValue.background {
                Task {
                    await fetchBackgroundImage()
                }
            }
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
    
    private func undoablyPerform(_ action: String, with undoManager: UndoManager? = nil, doit: () -> Void) {
        let oldEmojiArt = emojiArt
        doit()
        undoManager?.registerUndo(withTarget: self, handler: { myself in
            
            myself.undoablyPerform(action, with: undoManager) {
                myself.emojiArt = oldEmojiArt
            }
        })
        undoManager?.setActionName(action)
    }
    
    func setBackground(_ url: URL?, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("set background", with: undoManager) {
            emojiArt.background = url
        }
        
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat, undoWith undoManager: UndoManager? = nil) {
        undoablyPerform("add \(emoji)", with: undoManager) {
            emojiArt.addEmoji(emoji,
                              at: position,
                              size: Int(size))
        }
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
