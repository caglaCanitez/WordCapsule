//
//  HomePageTitleView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

struct HomePageTitleView: View {
    var body: some View {
        VStack {
            Text("WORD")
                .frame(width: 150, alignment: .leading)
            Text("CAPSULE")
                .frame(width: 225, alignment: .trailing)
        }
        .font(.title)
        .fontWeight(.medium)
        .foregroundColor(.white)
        .padding()
        .padding(.top, 10)
        .shadow(radius: 3, x: 0, y: 10)
    }
}

