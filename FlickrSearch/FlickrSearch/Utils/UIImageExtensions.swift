//
//  UIImageExtensions.swift
//  FlickrSearch
//
//  Created by Laurentiu Dascalu on 4/29/20.
//  Copyright © 2020 Laurentiu Dascalu. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

extension UIImage {

    // https://stackoverflow.com/questions/31966885/resize-uiimage-to-200x200pt-px
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(
            x: 0,
            y: 0,
            width: newSize.width,
            height: newSize.height
        ).integral

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)

        if
            let context = UIGraphicsGetCurrentContext(),
            let cgImage = self.cgImage
        {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(
                a: 1,
                b: 0,
                c: 0,
                d: -1,
                tx: 0,
                ty: newSize.height
            )
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)

            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}
