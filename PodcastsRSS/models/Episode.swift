//
//  Episode.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

struct Episode: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let audioURL: URL
    let duration: TimeInterval
    let durationString: String
    let publishDate: Date
    var isFavorited: Bool = false
    
    // Adicione um inicializador para definir automaticamente o UUID
    
    init(id: UUID = UUID(), title: String, description: String, audioURL: URL, duration: TimeInterval, durationString: String, publishDate: Date, isFavorited: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.audioURL = audioURL
        self.duration = duration
        self.durationString = durationString
        self.publishDate = publishDate
        self.isFavorited = isFavorited
    }
}
