//
//  WordCapsuleApp.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 8.11.2023.
//

import SwiftUI

class WordViewModel: ObservableObject {
    // A
    @Published var A1: [Word] = []
    @Published var A2: [Word] = []
    // B
    @Published var B1: [Word] = []
    @Published var B2: [Word] = []
    // C
    @Published var C1: [Word] = []
    @Published var C2: [Word] = []
    
    
    init() {
        // A
        A1 = WordReader.shared.readJSON(name: "A1")
        A2 = WordReader.shared.readJSON(name: "A2")
        // B
        B1 = WordReader.shared.readJSON(name: "B1")
        B2 = WordReader.shared.readJSON(name: "B2")
        // C
        C1 = WordReader.shared.readJSON(name: "C1")
        C2 = WordReader.shared.readJSON(name: "C2")
    }
    
    func getWord(level: Int) -> [Word] {
        return switch level {
        case 1:
            A1
        case 2:
            A2
        case 3:
            B1
        case 4:
            B2
        case 5:
            C1
        case 6:
            C2
        default:
            A1
        }
    }
}

@main
struct WordCapsuleApp: App {
    
    @StateObject var wordViewModel: WordViewModel = WordViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordViewModel)
        }
    }
}
