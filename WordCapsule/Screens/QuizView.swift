//
//  QuizView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var wordModel: WordModel
    @State var count: Int
    
    let height = UIScreen.main.bounds.height / 2
    let width = UIScreen.main.bounds.width / 1.3
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                    
                    Text("REMAINING TIME")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(.wordText)
                    
                    Text("\(count)")
                    
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(wordModel.color)
                        .frame(width: width, height: height)
                        .overlay {
                            VStack {
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.white)
                                    .frame(width: width/2, height: height/3)
                                    .padding()
                                    .overlay(
                                        Text(wordModel.currentWordWithAnswers.word.word.capitalized)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(wordModel.color)
                                    )
                                
                                Spacer()
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(wordModel.currentWordWithAnswers.answerOptions, id: \.self) { option in
                                        Button {
                                            wordModel.checkAnswer(answer: option)
                                            wordModel.showNextWord(for: .Quiz)
                                            count = wordModel.duration
                                        } label: {
                                            RoundedRectangle(cornerRadius: 30)
                                                .foregroundColor(.white)
                                                .frame(height: 50)
                                                .padding()
                                                .overlay {
                                                    Text(option)
                                                        .foregroundColor(wordModel.color)
                                                }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    if wordModel.currentIndex < wordModel.listCount - 1 {
                                        IconButtonView(iconType: .forward) {
                                            wordModel.showNextWord(for: .Quiz)
                                            count = wordModel.duration
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .shadow(radius: 10)
                        .padding()
                    
                    VStack {
                        wordModel.answerStatus.iconView
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(wordModel.color)
                        
                        wordModel.answerStatus.textView
                            .foregroundColor(.wordText)
                    }
                    
                    Spacer()
                }.onReceive(timer) { _ in
                    if count <= 1 {
                        if wordModel.currentIndex < wordModel.listCount - 1 {
                            wordModel.showNextWord(for: .Quiz)
                            count = wordModel.duration
                        }
                    } else {
                        count -= 1
                    }
                }
            }
        }
    }
}
