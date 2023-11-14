//
//  MatchMakingCodeGenerator.swift
//  WordCapsule
//
//  Created by yilmaz on 13.11.2023.
//

import Foundation

extension Date {
    var toMatchMakingDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter.string(from: self)
    }
}

extension String {
    var toMatchMakingDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        return formatter.date(from: self)
    }
}

struct MatchMakingCode: Codable {
    let level: Int
    let count: Int
    let duration: Int
    let expiryDate: Date
    let startIndex: Int
    let increment: Int
}

extension MatchMakingCode: CustomStringConvertible {
    var description: String {
        "\(level)-\(count)-\(duration)-\(expiryDate.toMatchMakingDateString)-\(startIndex)-\(increment)"
    }
    
    static func fromString(_ string: String) -> MatchMakingCode? {
        let components = string.components(separatedBy: "-")
        guard components.count == 6,
              let level = Int(components[0]),
              let count = Int(components[1]),
              let duration = Int(components[2]),
              let expiryDate = components[3].toMatchMakingDate,
              let startIndex = Int(components[4]),
              let increment = Int(components[5])
        else {
            return nil
        }

        return MatchMakingCode(level: level, count: count, duration: duration, expiryDate: expiryDate, startIndex: startIndex, increment: increment)
    }
}
