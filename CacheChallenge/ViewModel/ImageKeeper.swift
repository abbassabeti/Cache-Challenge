//
//  ImageKeeper.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import CoreGraphics
import Foundation

actor ImageKeeper {
    var images: [ImageData] = []
    
    init(images: [ImageData]) {
        self.images = images
    }
    
    func updateImage(index: Int, data: Data) async {
        guard let image = CGImage.from(data: data) else {
            self.images[index].updateFailedState()
            return
        }
        self.images[index].updateData(image)
    }
    
    func updateState(index: Int) async {
        self.images[index].updateFailedState()
    }
    
    func clearImage(index: Int) async {
        self.images[index].clearImage()
    }
}
