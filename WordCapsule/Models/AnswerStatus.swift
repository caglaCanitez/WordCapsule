//
//  AnswerStatus.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 23.01.2024.
//

import SwiftUI

enum AnswerStatus {
    case none
    case correct
    case incorrect

    var iconView: Image {
        switch self {
        case .correct:
            return Image(systemName: "checkmark.circle")
        case .incorrect:
            return Image(systemName: "xmark.circle")
        case .none:
            return Image(systemName: "questionmark.circle")
        }
    }
    
    var textView: Text {
        switch self {
        case .correct:
            return Text("CORRECT!")
        case .incorrect:
            return Text("WRONG!")
        case .none:
            return Text("Please answer.")
        }
    }
}
