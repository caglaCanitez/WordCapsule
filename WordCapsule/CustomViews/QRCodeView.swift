//
//  QRCodeView.swift
//  WordCapsule
//
//  Created by yilmaz on 13.11.2023.
//

import SwiftUI

struct QRCodeView: View {
    let image: Image

    var body: some View {
            image
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}
