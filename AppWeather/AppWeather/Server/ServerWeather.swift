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
    
    func requestDataServer(completion: @escaping (DataWeatherOneCity) -> Void, completionError: @escaping (Bool) -> Void, nameCity: String) {
        var checkIs: Bool = true
        // check input nameCity truyền vào.
        var containsWhitespace : Bool {
            return(nameCity.rangeOfCharacter(from: .whitespaces) != nil)
        }
        
        guard containsWhitespace == false else {
            DispatchQueue.main.async {
                checkIs = false
                completionError(checkIs)
            }
            return
        }
        
        
        guard let urlString = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity),%7Bstate%20code%7D&appid=785da7dc006dda8f97cd5e89504ccb4c") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {(data, response, error) in
            guard error == nil else {
                return
            }
            guard let dataresuld = data else {
                return
            }
            do {
                let dataResuld = try JSONDecoder().decode(DataWeatherOneCity.self, from: dataresuld)
                DispatchQueue.main.async {
                    completion(dataResuld)
                }
            } catch {
                checkIs = false
                DispatchQueue.main.async {
                    completionError(checkIs)
                }
            }
        }
        task.resume()
    
        
    }
}




