//
//  PaletteEditor.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/26/23.
//

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    
    private let emojiFont = Font.system(size: 40)
    @State private var emojisToAdd = ""
    
    enum Focused {
        case name
        case addEmojis
    }
    
    @FocusState private var focused: Focused?
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $palette.name)
                    .focused($focused, equals: .name)
            }
            
            Section(header: Text("Emojis")) {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .focused($focused, equals: .addEmojis)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) {
                        palette.emojis = (emojisToAdd + palette.emojis)
                            .filter { $0.isEmoji }
                            .uniqued
                    }
                removeEmojis
            }
            
            
        }
        .frame(minWidth: 300, minHeight: 350)
        .onAppear {
            if palette.name.isEmpty {
                focused = .name
            } else {
                focused = .addEmojis
            }
        }
    }
    
    var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text("Tap to Remove Emojis").font(.caption).foregroundStyle(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init) , id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                palette.emojis.remove(emoji.first!)
                                emojisToAdd.remove(emoji.first!)
                            }
                        }
                }
            }
            
        }
        .font(emojiFont)
    }
}

//#Preview {
//    PaletteEditor(palette: Palette())
//}
