//
//  HomeViewController.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var serverLocation = ServerWeather.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        serverLocation.requestDataServer(completion: { dataWeather in
            print(dataWeather)
        })
        
    }
    
    
}
