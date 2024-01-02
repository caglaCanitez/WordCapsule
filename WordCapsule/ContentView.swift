//
//  ContentView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 8.11.2023.
//

import SwiftUI

struct WordButtonStyle: ViewModifier {
    let height: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: height)
            .background(Color.wordBackground)
            .overlay(
                RoundedRectangle(cornerRadius: (height ?? 0) / 6)
                    .stroke(Color.wordBorder, lineWidth: 3)
            )
    }
}

struct WordOptionView: View {
    let title: String
    let optionCount: Int
    let action: (Int) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        let indices = Array(0..<optionCount)
        ZStack {
            Color.wordBackground.ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(indices, id: \.self) { index in
                        let hight = UIScreen.main.bounds.height / 6
                        Button {
                            action(index)
                        } label: {
                            Text("Button \(index + 1)")
                            .font(.title)
                            .modifier(WordButtonStyle(height: hight))
                        }
                        
                    }
                }
                .padding()
            }
        }
        .navigationTitle(title)
    }
}

struct Option {
    let title: String
    let options: [String]
}

struct ContentView: View {
    @State var showNextView = false
    @State var viewIndex = 0
    let options: [Option] = [
        Option(title: "Make Your Step", options: ["Fight", "Training", "Quiz"]),
        Option(title: "Place to Challenge", options: ["Fight", "Training", "Quiz", "Fight", "Fight", "Fight", "Fight"]),
        Option(title: "Word Type", options: ["Fight", "Training", "Quiz"]),
        Option(title: "Word Count", options: ["Fight", "Training", "Quiz"]),
        Option(title: "Word Duration", options: ["Fight", "Training", "Quiz"])
    ]
    
    var body: some View {
        NavigationStack {
            WordOptionView(title: options[viewIndex].title, optionCount: 6) { index in
                print(viewIndex)
                if viewIndex == options.count - 1 {
                    showNextView = true
                } else {
                    viewIndex += 1
                }
            }
            .navigationDestination(isPresented: $showNextView) {
                StartTheFightView()
            }
            .navigationBarItems(
                leading: viewIndex > 0 ? Button(action: {
                    if viewIndex > 0 {
                        viewIndex -= 1
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                } : nil
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StartTheFightView: View {
    var body: some View {
        VStack {
            Text("Start To Fight")
        }
        .navigationTitle("Start To Fight")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
