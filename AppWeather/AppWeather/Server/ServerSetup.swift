//
//  ServerSetup.swift
//  AppWeather
//
//  Created by admin on 12/13/21.
//  Copyright © 2021 Long. All rights reserved.
//

import Foundation
import UIKit

class ServerSetup {
    static let shared = ServerSetup()
    var serverWeatherSevenDay = ServerWeatherSevenDay()
    var dataSevenDay: DataWeather?
    func requestSevenDays(completion: @escaping (DataWeather) -> Void) {
        serverWeatherSevenDay.requestSevenDay(completion: { dataWeather in
            self.dataSevenDay = dataWeather
            let imageDataDict:[String: DataWeather] = ["key": dataWeather]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationCenters.shared.notificationHome), object: nil, userInfo: imageDataDict)
            DispatchQueue.main.async {
                completion(dataWeather)
            }
        })
        
    }
    
}
