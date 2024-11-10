//
//  PodcastDetailsViewModel.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI
import Combine

class PodcastDetailsViewModel: ObservableObject {
    // Dados do Podcast
    @Published var podcastTitle: String = ""
    @Published var podcastImageURL: URL?
    @Published var podcastDescription: String = ""
    @Published var episodes: [Episode] = [] // Lista de episódios do podcast
    
    private let rssService: RSSService         // Serviço para carregar dados do podcast
    private let downloadService = DownloadService() // Serviço para gerenciar downloads de episódios
    private var cancellables = Set<AnyCancellable>() // Para gerenciar assinaturas do Combine

    // Inicializador
    init(rssService: RSSService) {
        self.rssService = rssService
    }
    
    // Carrega os detalhes do podcast usando a URL RSS
    func loadPodcastDetails(from url: URL) {
        rssService.fetchPodcast(from: url) { [weak self] result in
            switch result {
            case .success(let podcast):
                DispatchQueue.main.async {
                    self?.podcastTitle = podcast.title
                    self?.podcastImageURL = podcast.imageURL
                    self?.podcastDescription = podcast.description
                    self?.episodes = podcast.episodes
                }
            case .failure(let error):
                print("Erro ao carregar o podcast: \(error.localizedDescription)")
            }
        }
    }
    
    // Inicia o download de um episódio específico
    func downloadEpisode(_ episode: Episode) {
        downloadService.downloadEpisode(episode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let localURL):
                    print("Episódio baixado com sucesso em \(localURL)")
                    // Atualizar o estado de download se necessário
                    self?.updateEpisodeDownloadStatus(episode)
                case .failure(let error):
                    print("Erro ao baixar o episódio: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Verifica se o episódio já foi baixado
    func isEpisodeDownloaded(_ episode: Episode) -> Bool {
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(episode.audioURL.lastPathComponent)
        return FileManager.default.fileExists(atPath: destinationURL.path)
    }
    
    // Atualiza o estado do episódio para indicar se ele foi baixado
    private func updateEpisodeDownloadStatus(_ episode: Episode) {
        if let index = episodes.firstIndex(where: { $0.id == episode.id }) {
            episodes[index].isFavorited = true // Exemplo: aqui você poderia alterar o estado para indicar download concluído
        }
    }
}

