//
//  Iyo+Extension.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation
import CoreData
import SwiftUI
extension Iyo{
    var importance : Importance {
        get {
            Importance(rawValue: Int(importance_num)) ?? .normal
        }
        set {
            self.importance_num = Int32(newValue.rawValue)
        }
    }

}

enum Importance : Int{
    case low = 0
    case normal = 1
    case high = 2

    var importanceType:String{
        switch rawValue {
        case Importance.low.rawValue : return "low"
        case Importance.normal.rawValue : return "normal"
        case Importance.high.rawValue : return "high"
        default: return ""
        }
    }

    func importanceColor() -> Color{
        switch rawValue {
        case Importance.low.rawValue : return .green
        case Importance.normal.rawValue : return .orange
        case Importance.high.rawValue : return .red
        default: return .white
        }
    }
}

