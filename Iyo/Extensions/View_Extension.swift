//
//  View_Extension.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI
extension View {
  func fab<ImageView: View>(
    position: String,
    fgcolor:Color,
    color: Color,
    image: ImageView,
    action: @escaping () -> Void) -> some View {
        self.modifier(FAB(position:position,fgColor:fgcolor,color: color,
                                       image: image,
                                       action: action))
  }
}
