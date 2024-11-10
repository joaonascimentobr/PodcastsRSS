//
//  PodcastRepository.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

class PodcastRepository {
    private let rssService = RSSService()
    private let cacheService = CacheService()
    
    func fetchPodcast(from url: URL, useCache: Bool = true, completion: @escaping (Result<Podcast, Error>) -> Void) {
        if useCache, let cachedData = cacheService.cachedData(for: url.absoluteString) {
            // Decodificar e retornar o podcast a partir do cache, se implementado
            // Exemplo fictício (não implementado): completion(.success(decodedPodcastFromCache))
            return
        }
        
        rssService.fetchPodcast(from: url) { result in
            if case .success(let podcast) = result {
                // Codificar e salvar o podcast no cache
                // Exemplo fictício: cacheService.cacheData(encodedPodcastData, for: url.absoluteString)
            }
            completion(result)
        }
    }
}
