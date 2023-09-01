//
//  ColorUtil.swift
//  bookshop
//
//  Created by macos.li on 2022/5/15.
//
import Foundation
import UIKit

class ColorUtil {
    
    static let blue: UIColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
    
    static func use255Color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
