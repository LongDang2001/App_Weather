//
//  ServerWeather.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation

class ServerWeather {
    
    // key: 785da7dc006dda8f97cd5e89504ccb4c
    // location: Hanoi
    // lây giá trị hiện tại của thời tiết:
    
    static let shared = ServerWeather()
    func requestDataServer(completion: @escaping (DataWeatherOneCity) -> Void, completionError: @escaping (Bool) -> Void, nameCity: String) -> Bool {
        var checkIs: Bool = true
        guard let urlString = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity),%7Bstate%20code%7D&appid=785da7dc006dda8f97cd5e89504ccb4c") else {
            checkIs = false
            return false
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {(data, response, error) in
            guard error == nil else {
                checkIs = false
                return
            }
            guard let data = data else { return }
            do {
                let dataResuld = try JSONDecoder().decode(DataWeatherOneCity.self, from: data)
                print(dataResuld)
                DispatchQueue.main.async {
                    completion(dataResuld)
                    completionError(checkIs)
                }
            } catch {
                checkIs = false
                DispatchQueue.main.async {
                    completionError(checkIs)
                }
                print("error")
            }
        }
        print(checkIs)
        task.resume()
        return checkIs
        
    }
}




