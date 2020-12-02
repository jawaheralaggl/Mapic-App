//
//  Extensions.swift
//  Mapic
//
//  Created by Jawaher Alagel on 11/30/20.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainColor = UIColor.rgb(red: 129, green: 169, blue: 176)
}
