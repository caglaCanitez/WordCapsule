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
        guard wordList.indices.contains(currentIndex) else { return Word(word: "No more words", type: "", mean: "")}
        return wordList[currentIndex]
    }
    
    func fetchWords(forLevel level: String, wordCount: Int) {
        if let path = Bundle.main.path(forResource: level, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                
                var allWords = try decoder.decode([Word].self, from: data)
                
                var selectedWords: [Word] = []
                for _ in 0..<min(wordCount, allWords.count) {
                    if let randomWord = allWords.randomElement() {
                        selectedWords.append(randomWord)
                        if let index = allWords.firstIndex(of: randomWord) {
                            allWords.remove(at: index)
                        }
                    }
                }
                
                wordList = selectedWords
            } catch {
                print("Error reading JSON file: \(error)")
                wordList = []
            }
        } else {
            print("JSON file not found for level: \(level)")
            wordList = []
        }
    }
    
    func showNextWord() {
        currentIndex += 1
        if currentIndex >= wordList.count {
            currentIndex = -1
        }
    }
    
    func showBackWord() {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = -1
        }
    }
}
