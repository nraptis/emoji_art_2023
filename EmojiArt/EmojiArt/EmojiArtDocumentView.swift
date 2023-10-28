//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    typealias Emoji = EmojiArt.Emoji
    
    @Environment(\.undoManager) var undoManager
    
    @ObservedObject var document: EmojiArtDocument
    private let emojis = "😍💩🤡🫵🦫🚨🍎💋👻💀👽🎃🍗🌮⚽️🏀🏈🎾🎮🎰🧩🍕🚕🌷🦷🌵🍔🎂🐻‍❄️🪦"
    @ScaledMetric var paletteEmojiSize: CGFloat = 40
    
    var body: some View {
        VStack {
            documentBody
            PaletteChooser()
                .font(.system(size: paletteEmojiSize))
                .padding(.horizontal)
                .scrollIndicators(.hidden)
        }
        .toolbar {
            UndoButton()
        }
    }
    
    @State private var showBackgroundFailureAlert = false
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                if document.background.isFetching {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.blue)
                        .position(Emoji.Position.zero.in(geometry))
                }
                documentContents(in: geometry)
                    .scaleEffect(zoom * gestureZoom)
                    .offset(pan + gesturePan)
                
            }
            .gesture(panGesture.simultaneously(with: zoomGesture))
            .onTapGesture(count: 2) {
                zoomToFit(document.boundingBox,
                          in: geometry)
            }
            .dropDestination(for: Sturldata.self) { sturldatas, location in
                
                return drop(sturldatas, at: location, in: geometry)
            }
            .onChange(of: document.background.failureReason) {
                showBackgroundFailureAlert = document.background.failureReason != nil
            }
            .onChange(of: document.background.uiImage) {
                zoomToFit(document.background.uiImage?.size, in: geometry)
            }
            .alert("Set Background",
                   isPresented: $showBackgroundFailureAlert,
                   presenting: document.background.failureReason,
                   actions: { reason in
                Button("OK", role: .cancel) { }
                //Button("SuPeR", role: .destructive) { }
            }, message: { reason in
                VStack {
                    Text(reason)
                    Text(reason)
                }
            }
            )
        }
    }
    
    private func zoomToFit(_ size: CGSize?, in geometry: GeometryProxy) {
        if let size {
            zoomToFit(CGRect(center: .zero, size: size),
                      in: geometry)
        }
    }
    
    private func zoomToFit(_ rect: CGRect, in geometry: GeometryProxy) {
        withAnimation {
            
            if rect.size.width > 0, rect.size.height > 0,
               geometry.size.width > 0, geometry.size.height > 0 {
                let hZoom = geometry.size.width / rect.size.width
                let vZoom = geometry.size.height / rect.size.height
                zoom = min(hZoom, vZoom)
                pan = CGOffset(width: -rect.midX * zoom,
                               height: -rect.midY * zoom)
            }
            
            
        }
    }
    
    @ViewBuilder private func documentContents(in geometry: GeometryProxy) -> some View {
        
        if let uiImage = document.background.uiImage {
            Image(uiImage: uiImage)
                .position(Emoji.Position.zero.in(geometry))
        }
            
        ForEach(document.emojis) { emoji in
            Text(emoji.string)
                .font(emoji.font)
                .position(emoji.position.in(geometry))
        }
    }
    
    @State private var zoom: CGFloat = 0.5
    @State private var pan = CGOffset(width: 100, height: 100)
    
    @GestureState private var gestureZoom = CGFloat(1)
    @GestureState private var gesturePan = CGOffset.zero
    
    private var zoomGesture: some Gesture {
        MagnifyGesture()
            .updating($gestureZoom) { inMotionPinchScale, gestureZoom, _ in
                gestureZoom = inMotionPinchScale.magnification
            }
            .onEnded { endingPinchScale in
                zoom *= endingPinchScale.magnification
            }
    }
    
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { value, gesturePan, _ in
                gesturePan = value.translation
            }
            .onEnded { value in
                pan += value.translation
            }
    }
    
    
    
    private func drop(_ sturldatas: [Sturldata], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        for sturldata in sturldatas {
            switch sturldata {
            case .url(let url):
                document.setBackground(url, undoWith: undoManager)
                return true
            case .string(let emoji):
                document.addEmoji(emoji,
                                  at: emojiPosition(at: location, in: geometry),
                                  size: paletteEmojiSize / zoom,
                                  undoWith: undoManager)
            default:
                break
            }
            
        }
        return false
    }
    
    private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(x: Int((location.x - center.x - pan.width) / zoom),
                              y: Int(-(location.y - center.y - pan.height) / zoom))
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
                        .draggable(emoji)
                }
            }
        }
    }
}

#Preview {
    EmojiArtDocumentView(document: .init())
}
