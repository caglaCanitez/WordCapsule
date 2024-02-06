//
//  Level.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 24.01.2024.
//

import SwiftUI

enum Level: String, Codable {
    case A1
    case A2
    case B1
    case B2
    case C1
    case C2
    
    var stringValue: String {
        return self.rawValue
    }
    
    var color: Color {
        switch self {
        case .A1, .A2:
            return .red
        case .B1, .B2:
            return .blue
        case .C1, .C2:
            return .green
        }
    }
}
