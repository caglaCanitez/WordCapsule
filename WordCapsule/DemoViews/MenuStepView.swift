//
//  MenuStepView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

struct MenuStepView: View {
    @ObservedObject var menuModel: MenuModel
    @EnvironmentObject var wordModel: WordModel
    
    var menu: MenuModel.Menu
    var pageTitle: String {
        menu.pageTitle
    }
    var titles: [String] {
        menu.titles
    }
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        ZStack {
            // MARK: - Backgorund Layer
            if menu != .learningCase {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
            }
            
            // MARK: - Content Layer
            ScrollView(showsIndicators: false) {
                VStack{
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(titles.dropLast(titles.count % 2).indices, id: \.self) { index in
                            NavigationLink(value: menu) {
                                RectangleMenuView(menu: menuModel.selectedItem(at: index, for: menu))
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                setChoosedItem(at: index)
                            })
                        }
                    }
                    
                    LazyHStack {
                        ForEach(titles.suffix(titles.count % 2).indices, id: \.self) { index in
                            NavigationLink(value: menu) {
                                RectangleMenuView(menu: menuModel.selectedItem(at: index, for: menu))
                            }
                            .simultaneousGesture(TapGesture().onEnded{
                                setChoosedItem(at: index)
                            })
                        }
                    }
                }
                .navigationTitle(pageTitle)
                .toolbar(menu == .learningCase ? .hidden : .visible)
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(for: MenuModel.Menu.self) { menu in
                    if let next = menu.next {
                        MenuStepView(menuModel: menuModel, menu: next)
                    } else {
                        switch menuModel.choosedItems[.learningCase]?.value as? Int {
                        case 0:
                            if let level = menuModel.choosedItems[.level]?.value as? Level,
                               let wordCount = menuModel.choosedItems[.wordCount]?.value as? Int {
                                TrainingView(wordModel: wordModel)
                                    .onAppear {
                                        wordModel.fetchWords(forLevel: level, wordCount: wordCount)
                                    }
                            }
                        case 1:
                            QuizView()
                        case 2, _:
                            FightView()
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func setChoosedItem(at index: Int) {
        let selectedItem = menuModel.selectedItem(at: index, for: menu)
        
        if menuModel.choosedItems[menu]?.title != "" {
            menu.setMenuDefaultItem(in: &menuModel.choosedItems)
        }
        
        menuModel.choosedItems[menu] = selectedItem
    }
}
