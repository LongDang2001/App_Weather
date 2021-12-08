//
//  DetailListViewController.swift
//  AppWeather
//
//  Created by admin on 12/8/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class DetailListViewController: UIViewController {

    var dataArrCurrent: [Current]?
    var nameCityLocation: String?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbDecription: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailListTableViewCellId")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.myviewBackground
        view.backgroundColor = UIColor.myviewBackground
        lbLocation.text = nameCityLocation
        // Do any additional setup after loading the view.
    }
    @IBAction func btActionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension DetailListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrCurrent?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCellId", for: indexPath) as! DetailListTableViewCell
        let dataCell = dataArrCurrent?[indexPath.row]
        cell.lbdate.text = DateCurrent().convertTimeLongToDateShortEEEE(timeLong: dataCell?.dt ?? 0)
        cell.lbHour.text = TimeCurrent().converTimeLong(timeLong: dataCell?.dt ?? 0)
        cell.lbTem.text = String(Int((dataCell?.temp ?? 273) - 273.5)) + " C"
        cell.lbDescription.text = dataCell?.weather[0].weatherDescription
        cell.imgWeather.image = CheckImageWeather().checkImageWeather(description: dataCell?.weather[0].weatherDescription ?? "", timeLong: dataCell?.dt ?? 0)
        cell.lbTemp.text = String(Int((dataCell?.temp ?? 273) - 273.5)) + " C"
        cell.lbHumidy.text = String(dataCell?.humidity ?? 0) + "%"
        cell.lbWind.text = String(dataCell?.windSpeed ?? 0) + "km/h"
        cell.contentViews.backgroundColor = UIColor.myGrayContent
        cell.contentViews.layer.cornerRadius = CGFloat(20)
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
