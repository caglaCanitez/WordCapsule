//
//  QuizView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var wordModel: WordModel
    @State private var navigateToResultView = false
    @State var count: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let height = UIScreen.main.bounds.height / 2
    let width = UIScreen.main.bounds.width / 1.3
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        ZStack {
            // MARK: - Backgorund Layer
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            
            // MARK: - Content Layer
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer()
                    
                    RemaininTimeView(count: count)
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(wordModel.color)
                        .frame(width: width, height: height)
                        .overlay {
                            VStack {
                                Spacer()
                                
                                RectangleWordView(word: wordModel.currentWordWithAnswers.word.word,
                                                  color: wordModel.color)
                                
                                Spacer()
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(wordModel.currentWordWithAnswers.answerOptions, id: \.self) { option in
                                        RectangleAnswerView(option: option, color: wordModel.color) {
                                            checkAndShowNextAnswer(option: option)
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    if wordModel.currentIndex < wordModel.listWithAnswerCount - 1 {
                                        IconButtonView(iconType: .forward) {
                                            checkAndShowNextAnswer()
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .shadow(radius: 10)
                        .padding()
                    
                    AnswerStatusView(answerStatus: wordModel.answerStatus, color: wordModel.color)
                    
                    Spacer()
                    
                }
                .onReceive(timer) { _ in
                    if count <= 1 {
                        checkAndShowNextAnswer()
                    } else {
                        count -= 1
                    }
                }
                .navigationDestination(isPresented: $navigateToResultView) {
                    ResultView()
                }
            }
        }
    }
    
    private func checkAndShowNextAnswer(option: String? = nil) {
        if let option {
            wordModel.checkAnswer(answer: option)
        }
        
        if wordModel.currentIndex < wordModel.listWithAnswerCount - 1 {
            wordModel.showNextWord(for: .Quiz)
            count = wordModel.duration
        } else {
            navigateToResultView = true
        }
    }
}
