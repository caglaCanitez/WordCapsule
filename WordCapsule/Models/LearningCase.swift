//
//  LearningCase.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 24.01.2024.
//

import Foundation

enum LearningCase: String, Codable {
    case Training
    case Quiz
    case Fight
    
    var stringValue: String {
        return self.rawValue
    }
}
