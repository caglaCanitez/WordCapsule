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
}

@main
struct WordCapsuleApp: App {
    
//    @StateObject var wordViewModel: WordViewModel = WordViewModel()
    @StateObject var wordModel = WordModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordModel)
        }
    }
}
