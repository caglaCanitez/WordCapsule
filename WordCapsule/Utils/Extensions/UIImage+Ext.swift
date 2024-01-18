//
//  UIImage+Ext.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 3.01.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

extension UIImage {
    func parseQR() -> [String] {
        guard let image = CIImage(image: self) else {
            return []
        }

        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let features = detector?.features(in: image) ?? []

        return features.compactMap { feature in
            return (feature as? CIQRCodeFeature)?.messageString
        }
    }
}
