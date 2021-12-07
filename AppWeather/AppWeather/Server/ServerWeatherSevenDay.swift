//
//  ServerWeatherSevenDay.swift
//  AppWeather
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit

class ServerWeatherSevenDay {
    // lat: 21.2
    // lon: 105
    // exclude=daily là hiển thị dữ liệu cả ngày đó:
    // lấy dữ liệu của 7 ngày sau này:
    // link: https://api.openweathermap.org/data/2.5/onecall?lat=21.1&lon=105&exclude=daily&appid=785da7dc006dda8f97cd5e89504ccb4c
    
    // lấy dữ liệu theo từng giờ trong một ngày, và link này cũng lấy ra các ngày trong tương lai:  Cần phải fix Lại cách lấy đến ngày:
    // https://api.openweathermap.org/data/2.5/onecall?lat=21.1&lon=105&exclude=hourly,daily&appid=785da7dc006dda8f97cd5e89504ccb4c
    
    static let shared = ServerWeatherSevenDay()
    func requestSevenDay(completion: @escaping (DataWeather) -> Void) {
        guard let urlString = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=21.1&lon=105&exclude=daily&appid=785da7dc006dda8f97cd5e89504ccb4c") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {(data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            do {
                let dataResuld = try JSONDecoder().decode(DataWeather.self, from: data)
                DispatchQueue.main.async {
                    completion(dataResuld)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

