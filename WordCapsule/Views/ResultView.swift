//
//  ResultView.swift
//  WordCapsule
//
//  Created by yilmaz on 5.01.2024.
//

import SwiftUI

struct ResultView: View {
    
    let correctCount: Int
    let wrongCount: Int
    
    var body: some View {
        VStack(spacing: 50) {
            Text("\(correctCount) Correct!")
            
            Text("\(wrongCount) Wrong!")
            
            Button {
                print("Done")
            } label: {
                Text("Done")
            }
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .cornerRadius(8)

        }
        .font(.title)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Result View")
    }
}

#Preview {
    ResultView(correctCount: 10, wrongCount: 5)
}
