//
//  FavoritesView.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        List(viewModel.favorites) { episode in
            Text(episode.title)
                .padding()
        }
        .onAppear {
            viewModel.loadFavorites()
        }
        .navigationTitle("Favoritos")
    }
}
