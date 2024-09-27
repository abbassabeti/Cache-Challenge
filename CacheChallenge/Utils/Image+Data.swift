//
//  Image+Data.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import SwiftUI
import CoreGraphics
import ImageIO

extension CGImage {
    static func from(data: Data) -> CGImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
        else {
            return nil
        }
        return cgImage
    }
}
