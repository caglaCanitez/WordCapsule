//
//  QuizView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var wordModel: WordModel
    
    let height = UIScreen.main.bounds.height / 2
    let width = UIScreen.main.bounds.width / 1.3
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        let array: [String] = ["aaa", "bbb", "ccc", "ddd"]
        
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
                                        Text(wordModel.currentWord.word.capitalized)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(wordModel.color)
                                    )
                                
                                Spacer()
                                
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(array.indices, id: \.self) { index in
                                        Button {
                                            withAnimation {
                                                wordModel.checkAnswer(answer: array[index])
                                                wordModel.showNextWord()
                                            }
                                        } label: {
                                            RoundedRectangle(cornerRadius: 30)
                                                .foregroundColor(.white)
                                                .frame(height: 50)
                                                .padding()
                                                .overlay {
                                                    Text(array[index])
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
                                            wordModel.showNextWord()
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
                }
            }
        }
    }
}
