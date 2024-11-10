//
//  PlayerViewModel.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI
import AVFoundation
import Combine

class PlayerViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var playbackProgress: Double = 0.0
    @Published var currentTimeString: String = "00:00"
    @Published var durationString: String = "00:00"
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var episode: Episode

    init(episode: Episode) {
        self.episode = episode
        setupPlayer()
    }
    
    private func setupPlayer() {
        let playerItem = AVPlayerItem(url: episode.audioURL)
        player = AVPlayer(playerItem: playerItem)
        
        // Observa o tempo atual e atualiza o progresso
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self else { return }
            let currentSeconds = time.seconds
            let durationInSeconds = self.player?.currentItem?.duration.seconds ?? 1
            self.playbackProgress = currentSeconds / durationInSeconds
            self.currentTimeString = self.formatTime(currentSeconds)
            
            // Atualiza a duração somente quando for válida
            if durationInSeconds > 0 && self.durationString == "00:00" {
                self.durationString = self.formatTime(durationInSeconds)
            }
        }
    }
    
    func startPlaying() {
        player?.play()
        isPlaying = true
    }
    
    func stopPlaying() {
        player?.pause()
        isPlaying = false
        
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
        player = nil
    }
    
    func togglePlayPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func skipForward() {
        guard let currentTime = player?.currentTime() else { return }
        let newTime = CMTime(seconds: currentTime.seconds + 15, preferredTimescale: 600)
        player?.seek(to: newTime)
    }
    
    func skipBackward() {
        guard let currentTime = player?.currentTime() else { return }
        let newTime = CMTime(seconds: max(currentTime.seconds - 15, 0), preferredTimescale: 600)
        player?.seek(to: newTime)
    }
    
    private func formatTime(_ time: Double) -> String {
        guard !time.isNaN else { return "00:00" }
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
