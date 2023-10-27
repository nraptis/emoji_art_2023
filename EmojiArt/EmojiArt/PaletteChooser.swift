//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/24/23.
//

import SwiftUI

struct PaletteChooser: View {
    
    @EnvironmentObject var store: PaletteStore
    
    @State private var showPaletteEditor = false
    @State private var showPaletteList = false
    
    
    var body: some View {
        HStack {
            chooser
                //.popover(isPresented: $showPaletteEditor) {
                //    PaletteEditor()
                //}
            view(for: store.palettes[store.cursorIndex])
        }
        .clipped()
        .sheet(isPresented: $showPaletteEditor) {
            NavigationStack {
                PaletteEditor(palette: $store.palettes[store.cursorIndex])
                    .font(nil)
            }
        }
        .sheet(isPresented: $showPaletteList) {
            EditablePaletteList(store: store)
                .font(nil)
        }
        
    }
    
    var chooser: some View {
        AnimatedActionButton(systemImage: "paintpalette") {
            store.cursorIndex += 1
        }
        .contextMenu {
            gotoMenu
            AnimatedActionButton("New", systemImage: "plus") {
                store.insert(Palette(name: "", emojis: ""))
                showPaletteEditor = true
            }
            AnimatedActionButton("Delete", systemImage: "minus.circle", role: .destructive) {
                store.palettes.remove(at: store.cursorIndex)
            }
            AnimatedActionButton("Edit", systemImage: "pencil") {
                showPaletteEditor = true
            }
            AnimatedActionButton("List", systemImage: "list.bullet.rectangle.portrait") {
                showPaletteList = true
            }
            
        }
    }
    
    private var gotoMenu: some View {
        Menu {
            ForEach(store.palettes) { palette in
                AnimatedActionButton(palette.name) {
                    if let index = store.palettes.firstIndex(where: { $0.id == palette.id } ) {
                        store.cursorIndex = index
                    }
                }
            }
        } label: {
            Label("Go To", systemImage: "text.insert")
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

struct PaletteChooserPreviewProvider: PreviewProvider {
    
    struct Preview: View {
        @State private var palette = PaletteStore(name: "Preview").palettes.first!
        var body: some View {
            PaletteEditor(palette: $palette)
        }
        
    }
    
    static var previews: some View {
        Preview()
    }
    
    
}
