//
//  CheckImageWeather.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit

class CheckImageWeather {
    
    // lấy ra đc dữ liệu sau đó ass vào đây:
    func checkImageWeather(description: String, timeLong: Int) -> UIImage {
        // convert tu timelong sang so gio, tu do check den thoi gian:
        //let hour = Calendar.current.component(.hour, from: Date())
        var nameImg: String = ""
        var hourText: String = ""
        
        let timeLongDouble: Double = Double(timeLong)
        let date = Date(timeIntervalSince1970: TimeInterval(timeLongDouble))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH"
        var hour: Int = Int(dateFormatter.string(from: date)) ?? 0
        
        if (hour > 6 && hour < 18) {
           
        } else {
            hourText = "night"
        }
        if (description == "overcast clouds" ) {
            nameImg = "04n"
        } else if (description == "clear sky") {
            nameImg = "03n"
        } else if (description == "few clouds" && description == "scattered clouds") {
            nameImg = "04d"
        } else if (description == "broken clouds") {
            nameImg = "03d"
        } else {
            nameImg = "03n"
        }
        
        let imgResuld = nameImg + hourText
        let imgView = UIImage(named: imgResuld) ?? UIImage(named: "03n")
        return imgView!
    }
}
