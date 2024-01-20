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
    
    private var A1: [Word] = []
    private var A2: [Word] = []
    private var B1: [Word] = []
    private var B2: [Word] = []
    private var C1: [Word] = []
    private var C2: [Word] = []
    
    static let shared = WordModel()
    
    init() {
        A1 = WordModel.shared.readJSON(forLevel: "A1")
        A2 = WordModel.shared.readJSON(forLevel: "A2")
        
        B1 = WordModel.shared.readJSON(forLevel: "B1")
        B2 = WordModel.shared.readJSON(forLevel: "B2")
        
        C1 = WordModel.shared.readJSON(forLevel: "C1")
        C2 = WordModel.shared.readJSON(forLevel: "C2")
    }
    
    func readJSON(forLevel level: String) -> [Word] {
        guard let path = Bundle.main.path(forResource: level, ofType: "json") else {
            print("Couldn't find the file.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let words = try JSONDecoder().decode([Word].self, from: data)
            return words
        } catch {
            print("Error reading JSON: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchWords(forLevel level: String, wordCount: Int) {
        let fileName = "\(level).json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
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
            }
        } else {
            print("JSON file not found for level: \(level)")
        }
    }
}
