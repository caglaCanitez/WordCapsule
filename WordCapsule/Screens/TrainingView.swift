//
//  TrainingView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import SwiftUI

struct TrainingView: View {
    @ObservedObject var wordModel: WordModel
    
    let height = UIScreen.main.bounds.height / 2
    let width = UIScreen.main.bounds.width / 1.3
    
    var body: some View {
        ZStack {
            // MARK: - Backgorund Layer
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            
            // MARK: - Content Layer
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(wordModel.color)
                        .frame(width: width, height: height)
                        .overlay(
                            VStack {
                                HStack {
                                    IconButtonView(iconType: .speaker) {
                                        Player.shared.play(word: wordModel.currentWord.word)
                                    }
                                    
                                    Spacer()
                                    
//                                    IconButtonView(iconType: .bookmark) {
                                        // TODO: Add bookmark actions
//                                    }
                                }
                                
                                Spacer () 
                                
                                RectangleWordView(word: wordModel.currentWord.word,
                                                  color: wordModel.color)
                                
                                
                                Text(wordModel.currentWord.type)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text(wordModel.currentWord.mean.capitalized)
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                HStack {
                                    if wordModel.currentIndex > 0 {
                                        IconButtonView(iconType: .backward) {
                                            wordModel.showBackWord()
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if wordModel.currentIndex < wordModel.listCount - 1 {
                                        IconButtonView(iconType: .forward) {
                                            wordModel.showNextWord(for: .Training)
                                        }
                                    }
                                }
                            }
                        )
                        .shadow(radius: 10)
                        .padding()
                    
                    Spacer()
                }
            }
        }
    }
}
