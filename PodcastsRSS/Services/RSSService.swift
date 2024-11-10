//
//  RSSService.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation
import FeedKit

class RSSService {
    // Função para buscar e processar um podcast a partir de uma URL RSS
        func fetchPodcast(from url: URL, completion: @escaping (Result<Podcast, Error>) -> Void) {
            let parser = FeedParser(URL: url)
            parser.parseAsync { [self] result in
                switch result {
                case .success(let feed):
                    switch feed {
                    case .rss(let rssFeed):
                        // Extraia informações do podcast
                        let title = rssFeed.title ?? "Sem título"
                        let description = rssFeed.description ?? "Sem descrição"
                        let imageURL = URL(string: rssFeed.image?.url ?? "")
        
                        // Extraia episódios
                        let episodes = rssFeed.items?.compactMap { item -> Episode? in
                            guard let title = item.title,
                                  let audioURLString = item.enclosure?.attributes?.url,
                                  let audioURL = URL(string: audioURLString) else {
                                return nil
                            }
                            // Verifique se o campo iTunes está disponível e converta a duração para TimeInterval
                            let durationString = item.iTunes?.iTunesDuration ?? TimeInterval(0)
                            //let duration = convertToTimeInterval(durationString)  // Converte a String para TimeInterval
                            
                            return Episode(
                                title: title,
                                description: item.description ?? "Sem descrição",
                                audioURL: audioURL,
                                duration: durationString, // Usa TimeInterval para manipulação
                                durationString: Converter.timeIntervalToString(durationString),  // Usa String para exibição
                                publishDate: item.pubDate ?? Date()
                            )
                        } ?? []
                        
                        // Crie o objeto Podcast e retorne no completion
                        let podcast = Podcast(title: title, imageURL: imageURL, description: description, episodes: episodes)
                        completion(.success(podcast))
                        
                    default:
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Formato de feed não suportado"])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    // Função auxiliar para converter uma string de duração (HH:MM:SS ou MM:SS) para TimeInterval
    func convertToTimeInterval(_ durationString: String) -> TimeInterval {
        let components = durationString.split(separator: ":").reversed().compactMap { Double($0) }
        var timeInterval: TimeInterval = 0
        for (index, component) in components.enumerated() {
            timeInterval += component * pow(60, Double(index))
        }
        return timeInterval
    }
}
