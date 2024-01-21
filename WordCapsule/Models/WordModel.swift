//
//  WordModel.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 20.01.2024.
//

import Foundation

struct Word: Codable, Equatable {
    let word: String
    let type: String
    let mean: String
}

class WordModel: ObservableObject {
    @Published var wordList: [Word] = []
    @Published var currentIndex: Int = 0
    
    var currentWord: Word {
        wordList.indices.contains(currentIndex) ? wordList[currentIndex] : Word(word: "No more words", type: "", mean: "")
    }
    
    var listCount: Int {
        wordList.count
    }
    
    func fetchWords(forLevel level: String, wordCount: Int) {
//                var allWords = try decoder.decode([Word].self, from: data)
//
//                var selectedWords: [Word] = []
//                for _ in 0..<min(wordCount, allWords.count) {
//                    if let randomWord = allWords.randomElement() {
//                        selectedWords.append(randomWord)
//                        if let index = allWords.firstIndex(of: randomWord) {
//                            allWords.remove(at: index)
//                        }
//                    }
//                }
//
//                wordList = selectedWords
        
        guard let url = Bundle.main.url(forResource: level, withExtension: "json") else {
                print("JSON file not found for level: \(level)")
                wordList = []
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let allWords = try JSONDecoder().decode([Word].self, from: data)

                let shuffledWords = allWords.shuffled()
                wordList = Array(shuffledWords.prefix(min(wordCount, shuffledWords.count)))
            } catch {
                print("Error reading JSON file: \(error)")
                wordList = []
            }
    }
    
    func showBackWord() {
        currentIndex = max(0, currentIndex - 1)
    }
    
    func showNextWord() {
        currentIndex = min(wordList.count - 1, currentIndex + 1)
    }
}
