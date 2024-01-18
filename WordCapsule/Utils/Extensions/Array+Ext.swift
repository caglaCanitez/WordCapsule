//
//  Array+Ext.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
