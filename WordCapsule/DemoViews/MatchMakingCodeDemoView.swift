//
//  MatchMakingCodeDemoView.swift
//  WordCapsule
//
//  Created by yilmaz on 13.11.2023.
//

import SwiftUI

// Copy code, as String
// Paste code, as String
// Share qrCode
// add qrCode from gallery or camera

// make sure String code is valid.
// Encode with something before share


struct MatchMakingCodeDemoView: View {
    
    let level = 5
    let count = 30
    let duration = 60
    let expiryDate = Date()
    let startIndex = 0
    let increment = 1
    @State var matchmakingCode: String = ""
    
    let codeString = "5-30-60-2023/11/12 15:30:00-0-1"
    @State var uiImage = UIImage()
    
    @EnvironmentObject var wordViewModel: WordViewModel
    
    var body: some View {
        VStack {
            Text("\(wordViewModel.A1[0].word)")
            
            QRCodeView(image: Image(uiImage: uiImage))

            Text(uiImage.parseQR().description)
            
            Text(matchmakingCode)
            
            Text(MatchMakingCode.fromString(codeString)?.description ?? "")
        }
        .padding()
        .onAppear {
            uiImage = codeString.generateQRCode()
            matchmakingCode = MatchMakingCode(
                level: level,
                count: count,
                duration: duration,
                expiryDate: expiryDate,
                startIndex: startIndex,
                increment: increment
            ).description
        }
    }
}
