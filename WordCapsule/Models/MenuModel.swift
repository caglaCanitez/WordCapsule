//
//  MenuModel.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

class MenuModel: ObservableObject {
    enum Menu {
        case learningCase
        case level
        case wordCount
        case duration
        
        var pageTitle: String {
            switch self {
            case .learningCase:
                return ""
            case .level:
                return "Choose your level"
            case .wordCount:
                return "Choose word count"
            case .duration:
                return "Choose duration"
            }
        }
        
        var value: [Any] {
            switch self {
            case .learningCase:
                return [0, 1, 2]
            case .level:
                return ["A1", "A2", "B1", "B2", "C1", "C2"]
            case .wordCount:
                return [10, 20, 30, 40, 50, 60]
            case .duration:
                return [3, 5, 7, 10, 12, 15]
            }
        }
        
        var titles: [String] {
            switch self {
            case .learningCase:
                return ["Training", "Quiz", "Fight"]
            case .level:
                return ["Elementary", "Pre Intermediate", "Intermediate", "Upper Intermediate", "Advanced", "Proficient"]
            case .wordCount:
                return ["10 words", "20 words", "30 words", "40 words", "50 words", "60 words"]
            case .duration:
                return ["3 s", "5 s", "7 s", "10 s", "12 s", "15 s"]
            }
        }
        
        var subTitles: [String] {
            switch self {
                // TODO: Add subtitles for suitable pages
            default:
                return []
            }
        }
        
        var image: [String] {
            switch self {
            case .learningCase:
                return ["training", "quiz", "fight"]
            case .level:
                return ["a1", "a2", "b1", "b2", "c1", "c2"]
            default:
                return []
            }
        }
        
        var next: Menu? {
            switch self {
            case .learningCase:
                return .level
            case .level:
                return .wordCount
            case .wordCount:
                return .duration
            case .duration:
                return nil
            }
        }
        
        func setMenuDefaultItem(in choosedItems: inout [MenuModel.Menu: MenuModel.MenuItem]) {
            guard let nextMenu = self.next else { return }

            switch nextMenu {
            case .learningCase, .level, .wordCount, .duration:
                choosedItems[nextMenu] = MenuModel.MenuItem(value: (Any).self, title: "", subTitle: "", image: "")
                nextMenu.setMenuDefaultItem(in: &choosedItems)
            }
        }
    }
    
    @Published var choosedItems: [Menu: MenuItem] = [
        .learningCase: MenuItem(value: "", title: "", subTitle: "", image: ""),
        .level: MenuItem(value: "", title: "", subTitle: "", image: ""),
        .wordCount: MenuItem(value: 0, title: "", subTitle: "", image: ""),
        .duration: MenuItem(value: 0, title: "", subTitle: "", image: "")
    ]
    
    struct MenuItem {
        var value: Any
        var title: String
        var subTitle: String?
        var image: String?
    }
    
    func selectedItem(at index: Int, for selectedMenu: Menu) -> MenuItem {
        let value = selectedMenu.value[safe: index]
        let title = selectedMenu.titles[safe: index] ?? ""
        let subTitle = selectedMenu.subTitles[safe: index]
        let image = selectedMenu.image[safe: index]
        
        return MenuItem(value: value as Any, title: title, subTitle: subTitle, image: image)
    }
}
