//
//  ImageData.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import SwiftUI

enum LoadingState {
    case loading
    case loaded
    case failed
}

struct ImageData {
    
    let url: URL
    var imageData: CGImage?
    var state: LoadingState
    
    init(url: URL, imageData: CGImage?, state: LoadingState = .loading) {
        self.url = url
        self.imageData = imageData
        self.state = state
    }
    
    mutating func updateData(_ data: CGImage) {
        self.imageData = data
        self.state = .loaded
    }
    
    mutating func updateFailedState() {
        self.state = .failed
    }
    
    mutating func clearImage() {
        self.imageData = nil
    }
}
