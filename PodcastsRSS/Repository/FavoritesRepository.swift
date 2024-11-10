//
//  FavoritesRepository.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

class FavoritesRepository {
    private let favoritesKey = "favoriteEpisodes"
    
    func saveFavorite(_ episode: Episode) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == episode.id }) {
            favorites.append(episode)
            save(favorites)
        }
    }
    
    func removeFavorite(_ episode: Episode) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == episode.id }
        save(favorites)
    }
    
    func getFavorites() -> [Episode] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([Episode].self, from: data) else {
            return []
        }
        return favorites
    }
    
    private func save(_ favorites: [Episode]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
}
