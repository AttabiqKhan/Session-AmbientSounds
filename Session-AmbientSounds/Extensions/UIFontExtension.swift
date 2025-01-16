//
//  UIFontExtension.swift
//  AppExtensions
//
//  Created by Attabiq Khan on 30/10/2024.
//

import UIKit

public extension UIFont {
    
    static func regular(ofSize size: CGFloat) -> UIFont {
         return UIFont(name: "Figtree-Regular", size: size) ?? UIFont()
     }
    static func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Medium", size: size) ?? UIFont()
    }
    static func semiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-SemiBold", size: size) ?? UIFont()
    }
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Bold", size: size) ?? UIFont()
    }
    static func extraBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-ExtraBold", size: size) ?? UIFont()
    }
    static func poppinsMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
