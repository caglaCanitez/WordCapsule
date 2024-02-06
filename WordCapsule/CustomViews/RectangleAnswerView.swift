//
//  RectangleAnswerView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 28.01.2024.
//

import SwiftUI

struct RectangleAnswerView: View {
    let option: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .frame(height: 50)
                .padding()
                .overlay {
                    Text(option)
                        .foregroundColor(color)
                }
        }
    }
}
