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
    func checkImageWeather(temp: Double, humadily: Int, wind: Int) -> UIImage {
        let hour = Calendar.current.component(.hour, from: Date())
        
        var hourText: String = ""
        var tempText: String = ""
        var humadilyText: String = ""
        var windText: String = ""
        
        if (hour > 6 && hour < 18) {
            hourText = "sang"
        } else {
            hourText = "toi"
        }
        // nhiet do
        if (temp >= 32 ) {
            tempText = "nong"
        } else if (temp < 32 && temp > 10) {
            tempText = "lanh"
        } else if (temp <= 5) {
            tempText = "qualanh"
        }
        
        // do am:
        if (humadily >= 60 && humadily < 80 ) {
            humadilyText = "mua"
        } else if (humadily < 60 ) {
            humadilyText = "komua"
        } else if ( humadily >= 90) {
            humadilyText = "muato"
        }
        
        // wind
        if (wind < 38) {
            windText = "gionho"
        } else if (wind >= 38 && wind < 117) {
            windText = "giotrungbinh"
        } else if (wind > 117) {
            windText = "giosieuto"
        }
        
        let nameImg: String = tempText + humadilyText + windText + hourText
        let imgView = UIImage(named: nameImg) ?? UIImage(named: "nongmuanhogiotodem")
        return imgView!
    }
}
