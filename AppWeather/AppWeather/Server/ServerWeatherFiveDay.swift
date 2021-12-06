//
//  ServerWeatherFiveDay.swift
//  AppWeather
//
//  Created by admin on 12/3/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation

class ServerWeatherFiveDay {
    // lấy dữ liệu của 5 ngày trươc đó:
    // dt time là thời gian cách đây 5 ngày trướcL
    //
    static let shared = ServerWeatherFiveDay()
    func requestFiveDay(completion: @escaping (DataWeather) -> Void, setTimeLong: Int) {
        guard let urlString = URL(string: "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=21.1&lon=105.8342&dt=\(setTimeLong)&appid=785da7dc006dda8f97cd5e89504ccb4c") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {(data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            do {
                let dataResuld = try JSONDecoder().decode(DataWeather.self, from: data)
                print(dataResuld)
                //print(dataResuld.clouds.all)
                DispatchQueue.main.async {
                    completion(dataResuld)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // lat
    // lon:
    // link: https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=21.1&lon=105.8342&dt=1638400575&appid=785da7dc006dda8f97cd5e89504ccb4c
    
}
