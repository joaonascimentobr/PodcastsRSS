//
//  DownloadService.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Foundation

class DownloadService {
    
    func downloadEpisode(_ episode: Episode, completion: @escaping (Result<URL, Error>) -> Void) {
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(episode.audioURL.lastPathComponent)
        
        // Verifica se o arquivo já foi baixado e existe no local de destino
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            completion(.success(destinationURL))
            return
        }
        
        // Inicia o download do arquivo
        let downloadTask = URLSession.shared.downloadTask(with: episode.audioURL) { location, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Verifica se o local do arquivo baixado é válido
            guard let location = location else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro ao baixar o episódio"])))
                return
            }
            
            do {
                // Move o arquivo baixado para o destino final no dispositivo
                try FileManager.default.moveItem(at: location, to: destinationURL)
                completion(.success(destinationURL))
            } catch {
                completion(.failure(error))
            }
        }
        
        downloadTask.resume()
    }
    
    // Função para verificar se um episódio já foi baixado
    func isEpisodeDownloaded(_ episode: Episode) -> Bool {
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(episode.audioURL.lastPathComponent)
        return FileManager.default.fileExists(atPath: destinationURL.path)
    }
    
    // Função para excluir um episódio baixado
    func deleteDownloadedEpisode(_ episode: Episode) {
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent(episode.audioURL.lastPathComponent)
        do {
            if FileManager.default.fileExists(atPath: destinationURL.path) {
                try FileManager.default.removeItem(at: destinationURL)
                print("Episódio excluído com sucesso.")
            }
        } catch {
            print("Erro ao excluir o episódio: \(error.localizedDescription)")
        }
    }
}

