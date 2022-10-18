//
//  CheckBoxStyle.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    let iyoColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Image(systemName: configuration.isOn ? "checkmark.rectangle.fill": "rectangle")
                .resizable()
                .frame(width: 25,height: 25)
                .foregroundColor(self.iyoColor)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

//struct CheckBox_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBox()
//    }
//}
