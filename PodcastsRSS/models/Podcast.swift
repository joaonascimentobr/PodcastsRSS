//
//  Podcast.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

struct Podcast: Equatable {
    let title: String
    let imageURL: URL?
    let description: String
    let episodes: [Episode]
}
