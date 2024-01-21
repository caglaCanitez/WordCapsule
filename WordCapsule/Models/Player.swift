//
//  Player.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import AVFoundation

final class Player {
    static let shared = Player()
    private var audioPlayer = AVAudioPlayer()
    private let urlCache: URLCache

    private init() {
        let cacheSizeMemory = 50 * 1024 * 1024 // 50 MB
        let cacheDiskCapacity = 100 * 1024 * 1024 // 100 MB
        urlCache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheDiskCapacity, diskPath: "audioCache")
        URLCache.shared = urlCache
    }

    func play(word: String) {
        guard let url = URL(string: "https://dict.youdao.com/dictvoice?type=1&audio=\(word)") else {
            print("Error creating audio url")
            return
        }

        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) {
            playAudio(data: cachedResponse.data)
        } else {
            fetchDataAndPlay(url: url)
        }
    }

    private func fetchDataAndPlay(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self, let data else {
                print("Error fetching audio data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let cachedResponse = CachedURLResponse(response: response!, data: data)
            self.urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))

            self.playAudio(data: data)
        }.resume()
    }

    private func playAudio(data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}
