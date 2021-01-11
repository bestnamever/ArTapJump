//
//  ColorExtension.swift
//  something
//
//  Created by Yu Hong on 2021/1/9.
//

import Foundation
import UIKit

extension UIColor {
    
    static func randomColor() -> UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}
