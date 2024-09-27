//
//  ImageViewModel.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation

@Observable class ImagesViewModel {
    
    private var keeper: ImageKeeper
    private var imageTips: [ImageTip]
    var images: [ImageId]
    init(tips: [ImageTip]) {
        self.imageTips = tips
        let images = tips.map { $0.toData() }
        self.keeper = ImageKeeper(images: images)
        self.images = images.enumerated().map {
            ImageId(index: $0.offset, image: $0.element.imageData)
        }
    }
    
    func loadImage(index: Int) {
        Task {
            let images = await keeper.images
            guard index < images.count else { return }
            
            let url = images[index].url
            do {
                let data = try await ImageLoader.shared.loadImage(from: url)
                updateImage(index: index, image: data)
            } catch _ {
                updateImage(index: index, image: nil)
            }
        }
    }
    
    func clearImage(index: Int) {
        Task {
            await keeper.clearImage(index: index)
            await syncImagesWithKeeper()
        }
    }
    
    private func updateImage(index: Int, image: Data?) {
        Task {
            if let image {
                await self.keeper.updateImage(index: index, data: image)
            } else {
                await self.keeper.updateState(index: index)
            }
            await syncImagesWithKeeper()
        }
    }
    
    private func syncImagesWithKeeper() async {
        let images = await self.keeper.images
        await MainActor.run {
            self.images = images.enumerated().map {
                ImageId(index: $0.offset, image: $0.element.imageData)
            }
        }
    }
}

private extension ImageTip {
    func toData() -> ImageData {
        ImageData(url: url, imageData: nil)
    }
}
