//
//  converters.swift
//  PodcastsRSS
//
//  Created by Joao on 10/11/24.
//

import Foundation

class Converter {
    static func timeIntervalToString(_ timeInterval: TimeInterval) -> String {
        let time = Int(timeInterval)
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60

        if hours > 0 {
            // Formato "HH:mm:ss" para intervalos que têm horas
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            // Formato "mm:ss" para intervalos menores
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
