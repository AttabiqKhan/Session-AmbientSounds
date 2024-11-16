//
//  AutoresizingExtension.swift
//  AppExtensions
//
//  Created by Ali on 30/10/2024.
//

import UIKit

public extension Int {
    var autoSized: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = CGFloat(self)/930*100 //930 is the diagonal size of iphone 13
        return diagonalSize * percentage / 100
    }
    
    var widthRatio: CGFloat {
        let width = UIScreen.main.bounds.width/390.0 //screen width of iphone 13
        return CGFloat(self)*width
    }
    
}
