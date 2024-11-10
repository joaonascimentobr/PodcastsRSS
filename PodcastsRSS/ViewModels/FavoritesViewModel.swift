//
//  FavoritesViewModel.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Episode] = []
    private let favoritesRepository = FavoritesRepository()
    
    func loadFavorites() {
        favorites = favoritesRepository.getFavorites()
    }
    
    func toggleFavorite(for episode: Episode) {
        if favorites.contains(where: { $0.id == episode.id }) {
            favoritesRepository.removeFavorite(episode)
        } else {
            favoritesRepository.saveFavorite(episode)
        }
        loadFavorites()
    }
}
