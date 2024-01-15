//
//  RectangleMenuView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 15.01.2024.
//

import SwiftUI

struct RectangleMenuView: View {
    let height = UIScreen.main.bounds.height / 5
    let width = UIScreen.main.bounds.width / 2.5
    
    var menu: MenuModel.MenuItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(width: width, height: height)
            .overlay(
                VStack {
                    // TODO: every circle start same line
                    if let image = menu.image, !image.isEmpty {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: height/3)
                            .clipShape(Circle())
                    }

                    Text(menu.title)
                        .font(.title2)
                        .foregroundColor(Color.wordText)
                        .padding(.horizontal, 7)
                    
                    if let subTitle = menu.subTitle, !subTitle.isEmpty {
                        Text(menu.subTitle ?? "")
                            .font(.subheadline)
                            .foregroundColor(Color.wordText)
                    }
                    
                    
                    // TODO: Add progress bar
//                    if menu.showProgress {
//                        ProgressView(value: menu.learningProgress, total: word count in each level)
//                            .tint(.gray)
//                            .frame(width: width - 30)
//                    }
                }
            )
            .shadow(radius: 6, x: 0, y: 5)
            .padding(.all)
    }
}
