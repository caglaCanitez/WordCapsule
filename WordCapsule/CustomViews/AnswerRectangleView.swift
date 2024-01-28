//
//  AnswerRectangleView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 27.01.2024.
//

import SwiftUI

struct AnswerRectangleView: View {
    let answer: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(.white)
            .frame(height: 50)
            .padding()
            .overlay {
                Text(answer)
                    .foregroundColor(color)
            }
    }
}
