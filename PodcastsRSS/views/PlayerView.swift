//
//  PlayerView.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    @StateObject private var viewModel: PlayerViewModel
    var episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
        _viewModel = StateObject(wrappedValue: PlayerViewModel(episode: episode))
    }
    
    var body: some View {
        VStack {
            // Título do Episódio
            Text(episode.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            // Barra de Progresso
            ProgressView(value: viewModel.playbackProgress)
                .padding()
                .progressViewStyle(LinearProgressViewStyle())
            
            // Controles de Reprodução
            HStack(spacing: 40) {
                Button(action: {
                    viewModel.skipBackward()
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.largeTitle)
                }
                
                Button(action: {
                    viewModel.togglePlayPause()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                }
                
                Button(action: {
                    viewModel.skipForward()
                }) {
                    Image(systemName: "goforward.15")
                        .font(.largeTitle)
                }
            }
            .padding()
            
            // Tempo Atual e Duração
            HStack {
                Text(viewModel.currentTimeString)
                    .font(.subheadline)
                Spacer()
                Text(viewModel.durationString)
                    .font(.subheadline)
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.startPlaying()
        }
        .onDisappear {
            viewModel.stopPlaying()
        }
        .padding()
    }
}
