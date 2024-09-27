//
//  ImageLoader.swift
//  CacheChallenge
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation
import MyCache

enum ImageLoaderError: Error {
    case invalidResponse
    case loadError
}

class ImageLoader {
    
    static let shared = ImageLoader(cache: Cache())

    private let urlSession: URLSession
    private let cache: Cache

    public init(cache: Cache) {
        let configuration = URLSessionConfiguration.ephemeral
        self.urlSession = URLSession(configuration: configuration)
        self.cache = cache
    }

    func loadImage(from url: URL) async throws -> Data {
        do {
            if let data = await cache.loadImage(from: url) {
                return data
            }
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ImageLoaderError.invalidResponse
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                await cache.updateCache(for: url, data: data)
                return data
            } else {
                throw ImageLoaderError.invalidResponse
            }
        } catch _ {
            throw ImageLoaderError.loadError
        }
    }
}
