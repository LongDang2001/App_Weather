//
//  HomeViewController.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTemper: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbHumidy: UILabel!
    @IBOutlet weak var lbWind: UILabel!
    @IBOutlet weak var btViewReport: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var serverLocation = ServerWeather.shared
    var serverWeatherFiveDay = ServerWeatherFiveDay.shared
    var serverWeatherSevenDay = ServerWeatherSevenDay.shared
    
    var dataSevenDay: DataWeather?
    
     // trong màn home hiển thị ra thời tiết của bảy ngày sắp tới và thời tiết hiện tại:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(notification:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
      
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.myviewBackground
        
    }
    
    @objc func showSpinningWheel(notification: Notification) {
        
        if let dataWeather = notification.userInfo?["key"] as? DataWeather {
            self.dataSevenDay = dataWeather
            guard  let dataWeatherResuld = self.dataSevenDay else {
                return
            }
            setUpComponent(dataWeathers: dataWeatherResuld)
            collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    // fix lại cáh hiển thi, Sửa đổi cách gọi image. Thêm label mô tả thời tiết nữa:
    func setUpComponent(dataWeathers: DataWeather) {
        self.lbLocation.text = dataWeathers.timezone
        let dateCurrent = DateCurrent().convertTimeLongToDate(timeLong: dataWeathers.current.dt)
        self.lbDate.text = dateCurrent
        let imageView = CheckImageWeather().checkImageWeather(description: dataWeathers.current.weather[0].weatherDescription, timeLong: dataWeathers.current.dt)
        self.imgWeather.image = imageView
        self.lbTemper.text = String(Int(dataWeathers.current.temp - 273.5)) + "c"
        self.lbDescription.text = dataWeathers.current.weather[0].weatherDescription
        self.lbTemp.text = String(Int(dataWeathers.current.temp - 273.5)) + "c"
        self.lbHumidy.text = String(dataWeathers.current.humidity) + "%"
        self.lbWind.text = String(dataWeathers.current.windSpeed) + "km/h"
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // collection view hiển thị thời tiết trong một ngày. tính theo từng giờ:
    // sang màn khác sẽ hiển thị danh sách thời tiết 7 ngày tiếp theo. Sang một màn khac sẽ hiển thị danh sách 5 ngày trước đây:

    // xử lý hiển thị dữ liệu ra màn collectionView:
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSevenDay?.hourly.count ?? 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        let dataCell = dataSevenDay?.hourly[indexPath.row]
        cell.lbDate.text = TimeCurrent().converTimeLong(timeLong: dataCell?.dt ?? 0)
        cell.lbTemp.text = String(Int((dataCell?.temp ?? 273) - 273.5)) + " C"
        cell.imgWeather.image = CheckImageWeather().checkImageWeather(description: (dataCell?.weather[0].weatherDescription ?? ""), timeLong: dataCell?.dt ?? 0)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height - 20)
        
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(50)
    }
    
    
}
