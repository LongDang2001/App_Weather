//
//  ViewReportController.swift
//  AppWeather
//
//  Created by admin on 12/7/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class ViewReportController: UIViewController {

    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataWeather: DataWeather?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.myviewBackground
        tableView.register(UINib(nibName: "TableViewReportCell", bundle: nil), forCellReuseIdentifier: "TableViewReportCellId")
        setUpComponent()
        print(dataWeather)
        
    }
    
    func setUpComponent() {
        lbLocation.text = dataWeather?.timezone
        lbDate.text = DateCurrent().convertTimeLongToDate(timeLong: dataWeather?.current.dt ?? 0)
    }
    @IBAction func btBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewReportController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataWeather?.hourly.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewReportCellId", for: indexPath) as! TableViewReportCell
        var dataCell = dataWeather?.hourly[indexPath.row]
        cell.lbDate.text = DateCurrent().convertTimeLongToDate(timeLong: dataCell?.dt ?? 0)
        cell.lbHour.text = TimeCurrent().converTimeLong(timeLong: dataCell?.dt ?? 0)
        cell.lbTem.text = String(Int((dataCell?.temp ?? 0) - 273.5)) + " C"
        cell.imgWeather.image = CheckImageWeather().checkImageWeather(description: dataCell?.weather[0].weatherDescription ?? "", timeLong: dataCell?.dt ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
}
