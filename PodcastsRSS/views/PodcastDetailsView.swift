//
//  PodcastDetailsView.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI

struct PodcastDetailsView: View {
    @StateObject private var viewModel: PodcastDetailsViewModel
    let podcastURL: URL  // URL do feed RSS do podcast

    init(podcastURL: URL) {
        self.podcastURL = podcastURL
        _viewModel = StateObject(wrappedValue: PodcastDetailsViewModel(rssService: RSSService()))
    }
    
    var body: some View {
        VStack {
            // Exibe a imagem do podcast, se disponível
            if let imageURL = viewModel.podcastImageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                         .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .padding()
            }

            // Exibe o título do podcast
            Text(viewModel.podcastTitle)
                .font(.title)
                .padding(.top)

            // Exibe a descrição do podcast
            Text(viewModel.podcastDescription)
                .padding()

            // Lista de episódios
            List(viewModel.episodes) { episode in
                HStack {
                    // Navegação para a tela de reprodução do episódio
                    NavigationLink(destination: PlayerView(episode: episode)) {
                        VStack(alignment: .leading) {
                            Text(episode.title)
                                .font(.headline)
                            Text(episode.durationString)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    // Botão de download ou ícone de status de download
                    if viewModel.isEpisodeDownloaded(episode) {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundColor(.blue)
                    } else {
                        Button(action: {
                            viewModel.downloadEpisode(episode)
                        }) {
                            Image(systemName: "arrow.down.circle")
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Detalhes do Podcast")
        .onAppear {
            viewModel.loadPodcastDetails(from: podcastURL)
        }
    }
}
