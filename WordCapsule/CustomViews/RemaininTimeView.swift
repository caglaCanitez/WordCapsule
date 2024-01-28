//
//  RemaininTimeView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 27.01.2024.
//

import SwiftUI

struct RemaininTimeView: View {
    let count: Int
    
    var body: some View {
        Text("REMAINING TIME")
            .font(.headline)
            .fontWeight(.light)
            .foregroundColor(.wordText)
        
        Text("\(count)")
    }
}
