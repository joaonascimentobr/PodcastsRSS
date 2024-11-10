//
//  RSSViewModel.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI
import Combine

class RSSViewModel: ObservableObject {
    // Entrada do usuário
    @Published var rssURL: String = ""
    
    // Estados de carregamento e erro
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // Armazena o podcast carregado
    @Published var podcast: Podcast?
    
    private let podcastRepository: PodcastRepository
    
    init(podcastRepository: PodcastRepository = PodcastRepository()) {
        self.podcastRepository = podcastRepository
    }
    
    // Função para validar e carregar o RSS
    func loadRSS() {
        guard let url = URL(string: rssURL), UIApplication.shared.canOpenURL(url) else {
            errorMessage = "URL inválida. Insira uma URL de RSS válida."
            showError = true
            return
        }
        
        isLoading = true
        showError = false
        
        podcastRepository.fetchPodcast(from: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let podcast):
                    self?.podcast = podcast
                case .failure(let error):
                    self?.errorMessage = "Erro ao carregar o podcast: \(error.localizedDescription)"
                    self?.showError = true
                }
            }
        }
    }
    
    // Função para limpar a entrada e o estado
    func reset() {
        rssURL = ""
        podcast = nil
        showError = false
        errorMessage = ""
    }
}
