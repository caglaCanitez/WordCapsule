//
//  WordModel.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 20.01.2024.
//

import SwiftUI

final class WordModel: ObservableObject {
    @Published var wordList: [Word] = []
    @Published var wordsWithAnswers: [WordWithAnswers] = []
    @Published var currentIndex: Int = 0
    @Published var level: Level = .A1
    @Published var answerStatus: AnswerStatus = .none
    @Published var duration: Int = 0
    
    var currentWord: Word {
        wordList.indices.contains(currentIndex) ? wordList[currentIndex] :
        Word(word: "No more words", type: "", mean: "")
    }
    
    var currentWordWithAnswers: WordWithAnswers {
        wordsWithAnswers.indices.contains(currentIndex) ? wordsWithAnswers[currentIndex] :
        WordWithAnswers(word: Word(word: "", type: "", mean: ""), answerOptions: [])
    }
    
    var listCount: Int {
        wordList.count
    }
    
    var listWithAnswerCount: Int {
        wordsWithAnswers.count
    }
    
    var color: Color {
        level.color
    }
    
    func fetchWordList(for level: Level, wordCount: Int) {
        do {
            self.level = level
            let allWords = try fetchWords(for: level, wordCount: wordCount)
            wordList = selectRandomWords(from: allWords, count: wordCount)
        } catch {
            print("Error fetching words: \(error.localizedDescription)")
            wordList = []
        }
    }
    
    func fetchWordListWithAnswers(for level: Level, wordCount: Int, duration: Int) {
        do {
            self.level = level
            self.duration = duration
            
            let allWords = try fetchWords(for: level, wordCount: wordCount)
            wordsWithAnswers = selectRandomWords(from: allWords, count: wordCount).map { word in
                let answerOptions = generateAnswerOptions(correctAnswer: word.mean, allWords: allWords)
                return WordWithAnswers(word: word, answerOptions: answerOptions)
            }
        } catch {
            print("Error fetching words with answers: \(error.localizedDescription)")
            wordsWithAnswers = []
        }
    }
    
    private func fetchWords(for level: Level, wordCount: Int) throws -> [Word] {
        guard let url = Bundle.main.url(forResource: level.stringValue, withExtension: "json") else {
            wordList = []
            wordsWithAnswers = []
            throw NSError(domain: "AppErrorDomain", code: 404, userInfo: ["description": "JSON file not found for level: \(level)"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Word].self, from: data)
    }
    
    private func selectRandomWords(from allWords: [Word], count: Int) -> [Word] {
        let shuffledWords = allWords.shuffled()
        return Array(shuffledWords.prefix(min(count, shuffledWords.count)))
    }
    
    private func generateAnswerOptions(correctAnswer: String, allWords: [Word]) -> [String] {
        var answerOptions = Set<String>()
        answerOptions.insert(correctAnswer)
        
        while answerOptions.count < 4 {
            let randomWord = allWords.randomElement()?.mean ?? ""
            if !answerOptions.contains(randomWord) {
                answerOptions.insert(randomWord)
            }
        }
        
        return Array(answerOptions)
    }
    
    func checkAnswer(answer: String) {
        if answer.lowercased() == currentWordWithAnswers.word.mean.lowercased() {
            answerStatus = .correct
        } else {
            answerStatus = .incorrect
        }
        
        self.currentIndex = min(self.wordsWithAnswers.count - 1, self.currentIndex + 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.answerStatus = .none
        }
    }
    
    func showBackWord() {
        currentIndex = max(0, currentIndex - 1)
    }
    
    func showNextWord(for learningCase: LearningCase) {
        switch learningCase {
        case .Training:
            currentIndex = min(wordList.count - 1, currentIndex + 1)
        case .Quiz:
            currentIndex = min(wordsWithAnswers.count - 1, currentIndex + 1)
            answerStatus = .none
        case .Fight:
            break
        }
    }
}
