//
//  WordModel.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 20.01.2024.
//

import SwiftUI

struct Word: Codable, Equatable {
    let word: String
    let type: String
    let mean: String
}

enum Level: String, Codable {
    case A1
    case A2
    case B1
    case B2
    case C1
    case C2
    
    var stringValue: String {
        return self.rawValue
    }
    
    var color: Color {
        switch self {
        case .A1, .A2:
            return .red
        case .B1, .B2:
            return .blue
        case .C1, .C2:
            return .green
        }
    }
}

class WordModel: ObservableObject {
    @Published var wordList: [Word] = []
    @Published var currentIndex: Int = 0
    @Published var level: Level = .A1
    @Published var answerStatus: AnswerStatus = .none
    
    var currentWord: Word {
        wordList.indices.contains(currentIndex) ? wordList[currentIndex] : Word(word: "No more words", type: "", mean: "")
    }
    
    var listCount: Int {
        wordList.count
    }
    
    var color: Color {
        level.color
    }
    
    func fetchWords(forLevel level: Level, wordCount: Int) {
        guard let url = Bundle.main.url(forResource: level.stringValue, withExtension: "json") else {
            print("JSON file not found for level: \(level)")
            wordList = []
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let allWords = try JSONDecoder().decode([Word].self, from: data)
            
            let shuffledWords = allWords.shuffled()
            wordList = Array(shuffledWords.prefix(min(wordCount, shuffledWords.count)))
            self.level = level
        } catch {
            print("Error reading JSON file: \(error)")
            wordList = []
        }
    }
    
    func checkAnswer(answer: String) {
        if answer.lowercased() == currentWord.mean.lowercased() {
            answerStatus = .correct
        } else {
            answerStatus = .incorrect
        }
    }
    
    func showBackWord() {
        currentIndex = max(0, currentIndex - 1)
    }
    
    func showNextWord() {
        currentIndex = min(wordList.count - 1, currentIndex + 1)
    }
}
