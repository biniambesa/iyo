//
//  Fab.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI

struct FAB<ImageView: View>: ViewModifier {
    let position:String
    let fgColor:Color
    let color: Color
    let image: ImageView
    let action: () -> Void
    
    
    private let size: CGFloat = 60
    private let margin: CGFloat = 100
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            ZStack {
                Color.clear
                content
                if (position == "BOTTOM") {button(geo)}
            }
        }
    }
    
    @ViewBuilder private func button(_ geo: GeometryProxy) -> some View {
        let top:CGFloat = -325;
        let bottom = ((geo.size.height - size) / 2 - margin);
        image
            .imageScale(.large)
            .frame(width: size, height: size)
            .background(Circle().fill(color))
            .foregroundColor(fgColor)
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onTapGesture(perform: action)
            .offset(x: (geo.size.width - size) / 2 - 15,
                    y: (position == "TOP" ? top : bottom))
    }
}


                
