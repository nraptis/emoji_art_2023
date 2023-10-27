//
//  PaletteManager.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/26/23.
//

import SwiftUI

struct PaletteManager: View {
    
    let stores: [PaletteStore]
    
    @State private var selectedStore: PaletteStore?
    
    var body: some View {
        NavigationSplitView {
            List(stores, selection: $selectedStore) { store in
                Text(store.name) // Bad!!
                    .tag(store)
            }
        } content: {
            if let selectedStore {
                EditablePaletteList(store: selectedStore)
            }
        } detail: {
            
            
            
            Text("Choose a store")
        }
    }
}
