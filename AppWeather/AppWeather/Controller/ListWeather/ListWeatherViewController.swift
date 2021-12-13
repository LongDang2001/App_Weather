//
//  ListWeatherViewController.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class ListWeatherViewController: UIViewController {

    // lấy đc data về màn này: cần lấy cả thời tiết 7 ngày sắp tới và thời tiết 5 ngày trước:
    // hiển thị data bằng cách trng một tableView hiển thị bên trong một colectionview:  đầu tiên là phải lấy ra đc data trước:
    var dataSevenDay: DataWeather?
    var dataFiveDay: DataWeather?
    var dataSevenDayDict: [String: [Current]] = [:]
    var dataFiveDayDict: [String: [Current]] = [:]
    var dataResuldFive: [Current] = []
    var dataResuldSeven: [Current] = []
    var serverWeatherFiveDay = ServerWeatherFiveDay()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(ServerWeatherFiveDay.shared.dataWeatherFiveDay)
        tableView.backgroundColor = UIColor.myviewBackground
        tableView.register(UINib(nibName: "ListWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "ListWeatherTableViewCellId")
        tableView.dataSource = self
        tableView.delegate = self
        // call data fiveday: gọi trong màn listWeather trong viewDidLoad:
        serverWeatherFiveDay.requestFiveDay(completion: { dataWeatherFive in
            self.dataFiveDay = dataWeatherFive
            guard let dataFivedays = self.dataFiveDay else {
                return
            }
            guard let dataSevenDays = self.dataSevenDay else {
                return
            }
            self.checkDateDiferent(dataSevendays: dataSevenDays, dataFivedays: dataFivedays)
            self.tableView.reloadData()
        }, setTimeLong: TimeCurrent().timeInterver() - Int(2 * 86400))
    }
    
    
    func checkDateDiferent(dataSevendays: DataWeather, dataFivedays: DataWeather) {
        
        for item in dataSevendays.hourly {
            let keyDate = DateCurrent().convertTimeLongToDateShort(timeLong: item.dt)
            if var valueSeven = dataSevenDayDict[keyDate] {
                // lấy giá trị của diction để sau truyền giá trị qua màn detail:
                valueSeven.append(item)
                dataSevenDayDict[keyDate] = valueSeven
                
            } else {
                dataResuldSeven.append(item)
                dataSevenDayDict[keyDate] = [item]
            }
        }
        for items in dataFivedays.hourly {
            let keyDate = DateCurrent().convertTimeLongToDateShort(timeLong: items.dt)
            if var valueFive = dataFiveDayDict[keyDate] {
                valueFive.append(items)
                dataFiveDayDict[keyDate] = valueFive
            } else {
                dataResuldFive.append(items)
                dataFiveDayDict[keyDate] = [items]
            }
        }
    }
}

// MARK: TableView
extension ListWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            print(dataResuldSeven.count)
            return dataResuldSeven.count
            
        }
        print(dataResuldFive.count)
        return dataResuldFive.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListWeatherTableViewCellId", for: indexPath) as! ListWeatherTableViewCell
        cell.contentViews.layer.cornerRadius = CGFloat(20)
        cell.contentViews.clipsToBounds = true
        cell.contentViews.backgroundColor = UIColor.myGrayContent
        if (indexPath.section == 0) {
            let dataSevenCell = dataResuldSeven[indexPath.row]
           
            cell.lbDate.text = DateCurrent().convertTimeLongToDate(timeLong: dataSevenCell.dt)
            cell.lbDayOfWeak.text = DateCurrent().convertTimeLongToDateShortEEEE(timeLong: dataSevenCell.dt)
            cell.lbTemp.text = String(Int(dataSevenCell.temp - 275.5)) + " C"
            cell.imgWeather.image = CheckImageWeather().checkImageWeather(description: dataSevenCell.weather[0].icon, timeLong: dataSevenCell.dt)
            
            
        } else if (indexPath.section == 1) {
            let dataFiveCell = dataResuldFive[indexPath.row]
             cell.lbDate.text = DateCurrent().convertTimeLongToDate(timeLong: dataFiveCell.dt)
             cell.lbDayOfWeak.text = DateCurrent().convertTimeLongToDateShortEEEE(timeLong: dataFiveCell.dt)
             cell.lbTemp.text = String(Int(dataFiveCell.temp - 275.5)) + " C"
            // hien thi image: 
            cell.imgWeather.image = CheckImageWeather().checkImageWeather(description: dataFiveCell.weather[0].icon, timeLong: dataFiveCell.dt)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) {
            let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
            viewHeader.backgroundColor = UIColor.myviewBackground
            let lbText = UILabel(frame: CGRect(x: viewHeader.frame.minX + 15, y: 10, width: tableView.frame.width/2, height: 30))
            lbText.text = "Next Forecast"
            lbText.textColor = UIColor.white
            lbText.font = UIFont(name: "lato", size: 24)
            viewHeader.addSubview(lbText)
            return viewHeader
        }
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        viewHeader.backgroundColor = UIColor.myviewBackground
        let lbText = UILabel(frame: CGRect(x: viewHeader.frame.minX + 15, y: 10, width: tableView.frame.width/2, height: 30))
        lbText.text = "History Forecast"
        lbText.textColor = UIColor.white
        lbText.font = UIFont(name: "lato", size: 24)
        viewHeader.addSubview(lbText)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detailListView = DetailListViewController()
        detailListView.modalPresentationStyle = .fullScreen
        detailListView.modalTransitionStyle = .coverVertical
        if(indexPath.section == 0) {
            // truyền lại giá trị của từng giá trị của dữ liệu ngày đó:  hiển thị sang bên mảng detail:
            detailListView.dataArrCurrent = dataSevenDayDict[DateCurrent().convertTimeLongToDateShort(timeLong: dataResuldSeven[indexPath.row].dt)]
            detailListView.nameCityLocation = dataSevenDay?.timezone
            
        } else if (indexPath.section == 1) {
            detailListView.dataArrCurrent = dataFiveDayDict[DateCurrent().convertTimeLongToDateShort(timeLong: dataResuldFive[indexPath.row].dt)]
            detailListView.nameCityLocation = dataFiveDay?.timezone
        }
        
        self.present(detailListView, animated: true, completion: nil)
    }
    
}


