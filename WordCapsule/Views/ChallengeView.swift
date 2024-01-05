//
//  ChallengeView.swift
//  WordCapsule
//
//  Created by yilmaz on 4.01.2024.
//

import SwiftUI
import Combine

struct ChallengeView: View {
    
    @EnvironmentObject var wordViewModel: WordViewModel
    @State var words: [Word]
    let numberOfCapsules = 15
    @State var countdown = 0
    let duration: Int = 5
    @State var wordIndex = 0
    @State var nextWordButtonDisable = true
    @State var selectedWordIndex = -1
    
    @State private var shuffledWords: [Word] = []
    @State private var showAlert = false
    
    @State private var timerSubscription: Cancellable?
    @State private var showResultView = false
    @State private var correct = 0
    @State private var wrong = 0
    
    private func updateShuffledWords() {
        let correntMean = words[wordIndex].mean
        shuffledWords = Array(wordViewModel.A1.shuffled()[0..<numberOfCapsules])
        if !shuffledWords.contains(where: { shuffledWord in
            shuffledWord.mean == correntMean
        }) {
            let randomIndex = Int.random(in: 0..<numberOfCapsules)
            shuffledWords[randomIndex] = words[wordIndex]
        }
        print(shuffledWords.count)
    }
    
    func handleNextWordButton() {
        updateResults()
        if wordIndex == words.count - 1 {
            showResultView = true
        } else {
            wordIndex += 1
            updateShuffledWords()
            nextWordButtonDisable = true
            selectedWordIndex = -1
            startTimer()
        }
    }
    
    func alertMessage() -> Text {
        if selectedWordIndex == -1 {
            return Text("Learn English")
        } else if words[wordIndex].mean == shuffledWords[selectedWordIndex].mean {
            return Text("You know English")
        } else {
            return Text("Learn English")
        }
    }
    
    func updateResults() {
        if selectedWordIndex == -1 {
            wrong += 1
        } else if words[wordIndex].mean == shuffledWords[selectedWordIndex].mean {
            correct += 1
        } else {
            wrong += 1
        }
    }
    
    func startTimer() {
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if countdown < duration {
                    countdown += 1
                } else {
                    stopTimer()
                    countdown = 0
                    showAlert = true
                }
            }
    }
    
    func pauseTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    func stopTimer() {
        pauseTimer()
        countdown = 0
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        let indices = Array(0..<numberOfCapsules)
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Text("\(duration - countdown)")
                    Spacer()
                    Text(words[wordIndex].word)
                        .padding()
                        .border(.blue, width: 2)
                    Spacer()
                    Image(systemName: "speaker.wave.3")
                }
                .font(.title)
                .padding([.horizontal], 20)
                Spacer()
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(indices, id: \.self) { index in
                        Button {
                            nextWordButtonDisable = false
                            selectedWordIndex = index
                        } label: {
                            if shuffledWords.count != 0 {
                                Text(shuffledWords[index].mean)
                                    .foregroundStyle(Color.white)
                                    .padding()
                                    .background(Capsule().fill(selectedWordIndex == index ? Color.green : Color.blue))
                            } else {
                                Text("error")
                            }
                        }
                    }
                }
                .padding()
                Spacer()
                
                Button("Next Word") {
                    stopTimer()
                    countdown = 0
                    showAlert = true
                }
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .foregroundStyle(.white)
                .background(.blue)
                .cornerRadius(24)
                .padding()
                .disabled(nextWordButtonDisable)
                .opacity(nextWordButtonDisable ? 0.5 : 1)
            }
            
        }
        .onAppear {
            startTimer()
            updateShuffledWords()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Your Answer's Answer"),
                message: alertMessage(),
                dismissButton: .default(Text("OK")) {
                    handleNextWordButton()
                }
            )
        }
        .navigationDestination(isPresented: $showResultView) {
            ResultView(correctCount: correct, wrongCount: wrong)
        }
    }
}
