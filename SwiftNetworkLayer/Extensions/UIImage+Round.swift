//
//  UIImage+Round.swift
//  SwiftNetworkLayer
//
//  Created by Uber on 17/05/2021.
//

import UIKit

extension UIImage {
    
    var roundedImage: UIImage? {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in:rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
