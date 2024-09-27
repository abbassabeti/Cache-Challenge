//
//  ContentView.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import SwiftUI
import MyCache

struct ContentView: View {
    let itemHeight: CGFloat = {
        #if os(macOS)
        return 500
        #else
        return 190
        #endif
    }()
    var model = ImagesViewModel(tips: SampleImages.provideTips())
    
    var body: some View {
        ScrollView {
            HStack {
                LazyVGrid(columns: [GridItem(.fixed(300))]) {
                    ForEach(model.images) { image in
                        GridCell(data: image)
                            .frame(height: itemHeight)
                            .onAppear {
                                loadImage(index: image.index)
                            }
                            .onDisappear {
                                model.clearImage(index: image.index)
                            }
                    }
                }
            }
            .padding()
        }
    }
    
    func loadImage(index: Int) {
        model.loadImage(index: index)
    }
}

#Preview {
    ContentView()
}
