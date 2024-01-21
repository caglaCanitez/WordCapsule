//
//  IconButtonView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 21.01.2024.
//

import SwiftUI

struct IconButtonView: View {
    enum IconType {
        case forward
        case backward
        case speaker
        case bookmark
    }
    
    @State private var isBookmarked = false
    let iconType: IconType
    let action: () -> Void
    
    var systemName: String {
        switch iconType {
        case .forward:
            return "arrow.right"
        case .backward:
            return "arrow.backward"
        case .speaker:
            return "speaker.wave.3.fill"
        case .bookmark:
            return isBookmarked ? "bookmark.fill" : "bookmark"
        }
    }
    
    var body: some View {
        Button {
            if iconType == .bookmark {
                isBookmarked.toggle()
            }
            action()
        } label: {
            Image(systemName: systemName)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
        }
    }
}
