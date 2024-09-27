//
//  GridCell.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import SwiftUI

struct GridCell: View {
    var data: ImageId
    var body: some View {
        Group {
            HStack {
                if let image = data.image {
                    Image(decorative: image, scale: 1)
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
        }
    }
}
