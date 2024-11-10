//
//  NetworkReachability.swift
//  PodcastsRSS
//
//  Created by Joao on 09/11/24.
//

import Network

class NetworkReachability {
    static let shared = NetworkReachability()
    private let monitor = NWPathMonitor()
    private(set) var isConnected = false
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
}
