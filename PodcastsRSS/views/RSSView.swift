//
//  RSSView.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import SwiftUI

struct RSSView: View {
    @StateObject private var viewModel = RSSViewModel()
    @State private var navigateToDetails = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Insira a URL do RSS do Podcast")
                    .font(.headline)
                    .padding()
                
                TextField("Exemplo: https://feeds.megaphone.fm/la-cotorrisa", text: $viewModel.rssURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Button(action: {
                    viewModel.loadRSS()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Carregar Podcast")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .disabled(viewModel.isLoading || viewModel.rssURL.isEmpty)
                
                if viewModel.showError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Podcast RSS Loader")
            .navigationDestination(isPresented: $navigateToDetails) {
                if let podcastURL = URL(string: viewModel.rssURL) {
                    PodcastDetailsView(podcastURL: podcastURL)
                }
            }
            .onChange(of: viewModel.podcast) { oldValue, newValue in
                if newValue != nil {
                    navigateToDetails = true
                }
            }
        }
    }
}
