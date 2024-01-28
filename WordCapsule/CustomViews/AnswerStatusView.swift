//
//  AnswerStatusView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 27.01.2024.
//

import SwiftUI

struct AnswerStatusView: View {
    let answerStatus: AnswerStatus
    let color: Color
    
    var body: some View {
        VStack {
            answerStatus.iconView
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(color)
            
            answerStatus.textView
                .foregroundColor(.wordText)
        }
    }
}
