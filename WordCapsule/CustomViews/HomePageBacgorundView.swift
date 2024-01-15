//
//  HomePageBacgorundView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

struct HomePageBacgorundView: View {
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                Image("homePage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 250, alignment: .bottom)
                    .clipped()
                    .ignoresSafeArea()
                
                Spacer()
            }
        }
    }
}
