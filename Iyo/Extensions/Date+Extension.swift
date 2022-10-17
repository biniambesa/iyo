//
//  Date+Extension.swift
//  Iyo
//
//  Created by Sogah Mainib on 10/17/22.
//

import Foundation

extension Date {
    
    func getRemTime()-> String{
        let secondsLeft = Int(Date().timeIntervalSince(self))
        let pastOrFuture =  secondsLeft < 0 ? "FUTURE" : "PAST"
        let absoSec = abs(secondsLeft)
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if absoSec < minute {
            return "\(absoSec) seconds \(pastOrFuture == "FUTURE" ? "left" : "ago")"
        }
        
        else if absoSec < hour {
            return "\(absoSec / minute) minutes  \(pastOrFuture == "FUTURE" ? "left" : "ago")"
        }
        else if absoSec < day {
            return "\(absoSec / hour) hours  \(pastOrFuture == "FUTURE" ? "left" : "ago")"
        }
        else if absoSec < week {
            let daysCount = absoSec/day
            
            return "\(absoSec / day) \(daysCount > 1 ? "day" : "day")  \(pastOrFuture == "FUTURE" ? "left" : "ago")"
        }
        return "\(absoSec / week) weeks  \(pastOrFuture == "FUTURE" ? "left" : "ago")"
    }
    
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        }
        
        else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        }
        else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        }
        else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}
