//
//  ContentView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 8.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listModel = MenuModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Backgorund Layer
                HomePageBacgorundView()
                
                // MARK: - Content Layer
                ScrollView(showsIndicators: false) {
                    VStack {
                        HomePageTitleView()
                        
                        // TODO: Make spacer dynamic
                        Spacer(minLength: 90)
                        
                        MenuStepView(menuModel: listModel,
                                     menu: .learningCase)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
