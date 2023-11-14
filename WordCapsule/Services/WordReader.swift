//
//  WordLevelReader.swift
//  WordCapsule
//
//  Created by yilmaz on 12.11.2023.
//

import Foundation

struct WordLevelCount {
    // A
    static let A1 = 30
    static let A2 = 30
    // B
    static let B1 = 30
    static let B2 = 30
    // C
    static let C1 = 30
    static let C2 = 30
}

struct Word: Decodable {
    let word: String
    let type: String
    let mean: String
}

class WordReader {
    
    static let shared = WordReader()
    
    func readJSON(name: String) -> [Word] {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
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
}
