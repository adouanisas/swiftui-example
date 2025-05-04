//
//  AppFontName.swift
//  LeProto
//
//  Created by Ahmed Adouani on 03/02/2023.
//

import SwiftUI

extension UILabel {
    @discardableResult
    func appFontH1(_ size: CGFloat = 28) -> UILabel {
        font = UIFont(name: AppFontName.RoasterRegular, size: size*UIConstants.scalingFactor)
        return self
    }
    
    @discardableResult
    func appFontH1Bold(_ size: CGFloat = 28) -> UILabel {
        font = UIFont(name: AppFontName.RoasterBold, size: size*UIConstants.scalingFactor)
        return self
    }
}

extension Text {
    func appFontBody(_ size: CGFloat = 14) -> Text {
        self.font(.custom(AppFontName.SourceCodeProRegular, size: size*UIConstants.scalingFactor))
    }
    
    func appFontMenu(_ size: CGFloat = 10) -> Text {
        self.font(.custom(AppFontName.SourceCodeProSemiBold, size: size*UIConstants.scalingFactor))
    }
    
    func appFontH1(_ size: CGFloat = 28) -> Text {
        self.font(.custom(AppFontName.RoasterRegular, size: size*UIConstants.scalingFactor))
    }
    
    func appFontH2(_ size: CGFloat = 20) -> Text {
        self.font(.custom(AppFontName.RoasterBold, size: size*UIConstants.scalingFactor))
    }
}

extension TextField where Label == Text {
    func appFontH1() -> some View {
        self.font(.custom(AppFontName.RoasterRegular, size: 28*UIConstants.scalingFactor))
    }
}

private enum AppFontName {
    static let SourceCodeProRegular = "SourceCodePro-Regular"
    static let SourceCodeProSemiBold = "SourceCodePro-SemiBold"
    static let RoasterRegular = "Roaster-Regular"
    static let RoasterBold = "Roaster-Bold"
    
    static func printAll() {
        for family: String in UIFont.familyNames {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
    }
}

