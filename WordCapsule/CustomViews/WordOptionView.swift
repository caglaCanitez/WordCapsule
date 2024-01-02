//
//  WordOptionView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 3.01.2024.
//

import SwiftUI

struct WordOptionView: View {
    let option: Option
    let action: (Int) -> Void
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        let indices = Array(0..<option.stepOptions.count)
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(indices, id: \.self) { index in
                        let height = UIScreen.main.bounds.height / 6
                        Button {
                            action(index)
                        } label: {
                            Text(option.stepOptions[index])
                            .modifier(WordButtonStyle(height: height, color: option.buttonColors[index]))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(option.pageTitle)
    }
}

struct WordButtonStyle: ViewModifier {
    let height: CGFloat?
    let color: Color?
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: height)
            .padding(.all, 10)
            .background(
                color
                    .cornerRadius(10)
                    .shadow(radius: 6)
            )
    }
}
