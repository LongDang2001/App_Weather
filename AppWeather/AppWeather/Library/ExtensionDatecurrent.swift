//
//  ExtensionDatecurrent.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit

class DateCurrent {
    
    func dateCurrent() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func convertTimeLongToDate(timeLong: Int) -> String {
        let timeLongDouble: Double = Double(timeLong)
        let date = Date(timeIntervalSince1970: TimeInterval(timeLongDouble))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
      //dateFormatter.dateFormat = "EEEE MMM d yyyy"
        return dateFormatter.string(from: date)
    }
    
    func convertTimeLongToDateShort(timeLong: Int) -> String {
        let timeLongDouble: Double = Double(timeLong)
        let date = Date(timeIntervalSince1970: TimeInterval(timeLongDouble))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func convertTimeLongToDateShortEEEE(timeLong: Int) -> String {
        let timeLongDouble: Double = Double(timeLong)
        let date = Date(timeIntervalSince1970: TimeInterval(timeLongDouble))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

class TimeCurrent {
    
    func timeInterver() -> Int {
        let timeInterverData = Date().timeIntervalSince1970
        let timeInterver: Int = Int(timeInterverData)
        return timeInterver
    }
    
    func timeCurrent() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .short
        timeFormatter.timeZone = .current
        timeFormatter.locale = .current
        timeFormatter.dateFormat = "HH:mm"
        
        
        return timeFormatter.string(from: date)
    }
    
    func converTimeLong(timeLong: Int) -> String {
        let timeLongDouble: Double = Double(timeLong)
        let date = Date(timeIntervalSince1970: TimeInterval(timeLongDouble))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}


