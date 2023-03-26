//
//  TQr.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

///TQR -  QR Tool
///Class cointain function to help handle QR
class TQR{
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }

}
