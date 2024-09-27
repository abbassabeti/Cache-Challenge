//
//  ImageLoader.swift
//  MyCache
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation

// Cache Class with two caches: small and large image caches
public class Cache {
        
    private let smallImageCache = LRUCache<String, Data>(
        capacity: 5 * 1024 * 1024 // 5MB
    )
    private let largeImageCache = LRUCache<String, Data>(
        capacity: 20 * 1024 * 1024 // 20MB
    )

    private let largeImageThreshold = 2 * 1024 * 1024 // 2MB threshold
    
    public init() {}
    
    public func loadImage(from url: URL) async -> Data? {
        let key = url.absoluteString
        if let cachedImage = await smallImageCache.get(forKey: key) {
            return cachedImage
        }
        
        if let cachedLargeImage = await largeImageCache.get(forKey: key) {
            return cachedLargeImage
        }
        return nil
    }
    
    public func updateCache(for url: URL, data: Data) async {
        let key = url.absoluteString
        let dataSize = data.count
        if dataSize > self.largeImageThreshold {
            await self.updateLargeCache(data, forKey: key, size: dataSize)
        } else {
            await self.smallImageCache.set(data, forKey: key, size: dataSize)
        }
    }
    
    private func updateLargeCache(_ data: Data, forKey key: String, size: Int) async {
        await largeImageCache.set(data, forKey: key, size: size)
    }
    
    private func updateSmallCache(_ data: Data, forKey key: String, size: Int) async {
        await smallImageCache.set(data, forKey: key, size: size)
    }
}
