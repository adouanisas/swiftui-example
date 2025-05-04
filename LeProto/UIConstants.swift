//
//  UIConstants.swift
//  LeProto
//
//  Created by Ahmed Adouani on 04/02/2023.
//

import UIKit

enum UIConstants {
    
    static var hasTopNotch: Bool {
        Self.topPadding > 20
    }
    
    static var signInTopMargin: CGFloat {
        if Self.hasTopNotch {
            return CGFloat(9)
        } else {
            return CGFloat(36)
        }
    }
    
    static var signInBottomMargin: CGFloat {
        CGFloat(64)
        //Self.bottomPadding+CGFloat(64+64)
    }
    
    static var screenHorizontalPadding: CGFloat {
        CGFloat(24)
    }
    
    static var buttonHeight: CGFloat {
        CGFloat(56)*Self.scalingFactor
    }
    
    static var buttonMaxWidth: CGFloat {
        CGFloat(380)*Self.scalingFactor
    }
    
    static var buttonCornerRadius: CGFloat {
        CGFloat(15)*Self.scalingFactor
    }
    
    static var buttonBorderLineWidth: CGFloat {
        CGFloat(2)*Self.scalingFactor
    }
    
    static var buttonBorderShadowOffset: CGFloat {
        CGFloat(3)*Self.scalingFactor
    }
    
    static var bottomPadding: CGFloat {
        let window = UIApplication.shared.windows.first
        //let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        return bottomPadding ?? 0
    }
    
    static var topPadding: CGFloat {
        let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first
        let topPadding = window?.safeAreaInsets.top
        return topPadding ?? 0
    }
    
    static var screenWidth: CGFloat {
        let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first
        return window?.frame.width ?? 0
    }
    
    
    static var scalingFactor: CGFloat {
        if Self.hasTopNotch {
            return CGFloat(1.0)
        } else {
            return CGFloat(0.80)
        }
    }
    
    static var hours = ["00  :  00", "00  :  30",
                        "01  :  00", "01  :  30",
                        "02  :  00", "02  :  30",
                        "03  :  00", "03  :  30",
                        "04  :  00", "04  :  30",
                        "05  :  00", "05  :  30",
                        "06  :  00", "06  :  30",
                        "07  :  00", "07  :  30",
                        "08  :  00", "08  :  30",
                        "09  :  00", "09  :  30",
                        "10  :  00", "10  :  30",
                        "11  :  00", "11  :  30",
                        "12  :  00", "12  :  30",
                        "13  :  00", "13  :  30",
                        "14  :  00", "14  :  30",
                        "15  :  00", "15  :  30",
                        "16  :  00", "16  :  30",
                        "17  :  00", "17  :  30",
                        "18  :  00", "18  :  30",
                        "19  :  00", "19  :  30",
                        "20  :  00", "20  :  30",
                        "21  :  00", "21  :  30",
                        "22  :  00", "22  :  30",
                        "23  :  00", "23  :  30",
    ] // 1

}

