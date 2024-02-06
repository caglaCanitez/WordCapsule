//
//  RectangleWordView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 27.01.2024.
//

import SwiftUI

struct RectangleWordView: View {
    let height = UIScreen.main.bounds.height / 6
    let width = UIScreen.main.bounds.width / 2.6
    
    let word: String
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
            .frame(width: width, height: height)
            .padding()
            .overlay(
                Text(word.capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            )
    }
}
