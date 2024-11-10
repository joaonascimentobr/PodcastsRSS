//
//  CacheService.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

class CacheService {
    private let cache = NSCache<NSString, NSData>()

    func cacheData(_ data: Data, for key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }

    func cachedData(for key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
