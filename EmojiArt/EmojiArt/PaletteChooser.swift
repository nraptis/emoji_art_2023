//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/24/23.
//

import SwiftUI

struct PaletteChooser: View {
    
    @EnvironmentObject var store: PaletteStore
    
    var body: some View {
        HStack {
            chooser
            view(for: store.palettes[store.cursorIndex])
        }
        .clipped()
    }
    
    var chooser: some View {
        Button {
            withAnimation {
                store.cursorIndex += 1
            }
        } label: {
            Image(systemName: "paintpalette")
        }
        
        
    }
    
    func view(for palette: Palette) -> some View {
        HStack {
            Text(palette.name)
            ScrollingEmojis(emojis: palette.emojis)
        }
        .id(palette.id)
        .transition(.asymmetric(insertion: .move(edge: .bottom),
                                removal: .move(edge: .top)))
    }
    
}

#Preview {
    PaletteChooser()
        .environmentObject(PaletteStore(name: "Preview"))
}
