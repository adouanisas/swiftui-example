//
//  OverlayBlack.swift
//  LeProto
//
//  Created by Ahmed Adouani on 06/02/2023.
//

import SwiftUI

struct OverlayBlack: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            return content.overlay(.black)
        } else {
            return content.tag(1) // tag added for compiling fix
        }
    }
}
