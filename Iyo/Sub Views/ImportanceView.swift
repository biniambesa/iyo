//
//  ImportanceView.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import SwiftUI
struct ImportanceView: View {
    let importanceTitle :String
    @Binding var selectedImprtance: Importance
    
    var body: some View {
        Text(importanceTitle)
            .frame(maxWidth: .infinity)
            .font(.system(.headline, design: .rounded))
            .foregroundColor(.white)
            .padding(10)
            .background(selectedImprtance.importanceType == importanceTitle.lowercased() ? selectedImprtance.importanceColor() : Color(.systemGray6))
            .cornerRadius(10)
            
//            .border(Color.red)
        
    }
    
}


struct ImportanceView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            ImportanceView(importanceTitle: "Low", selectedImprtance: .constant(.low))
            
            ImportanceView(importanceTitle: "Normal", selectedImprtance: .constant(.normal))
            
            ImportanceView(importanceTitle: "High", selectedImprtance: .constant(.high))
        }//:HStack
    }
}
