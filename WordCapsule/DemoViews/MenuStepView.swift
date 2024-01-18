//
//  MenuStepView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

struct MenuStepView: View {
    @ObservedObject var menuModel: MenuModel
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
                        LearnNewWordView()
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
