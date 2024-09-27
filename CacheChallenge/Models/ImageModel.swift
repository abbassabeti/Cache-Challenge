//
//  ImageModel.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import CoreGraphics
import MyCache

struct ImageId: Identifiable {
    var id: Int {
        return index
    }
    let index: Int
    let image: CGImage?
}
