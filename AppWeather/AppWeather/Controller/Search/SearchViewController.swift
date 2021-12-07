//
//  SearchViewController.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UISearchTextFieldDelegate {

    // làm màn này, Duyệt theo tên, Nếu trả về giá trị thì hiển thị:
    @IBOutlet weak var btSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTempp: UILabel!
    @IBOutlet weak var lbHumidy: UILabel!
    @IBOutlet weak var lbWind: UILabel!
    
    
    @IBOutlet weak var btCancle: UIButton!
    var textSearchChangle: String = ""
    var dataWeatherSearch: DataWeatherOneCity?
    var requestWeather = ServerWeather.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataToSearch()
        txtSearch.delegate = self
    }
    
    @IBAction func btActionSearch(_ sender: Any) {
        
        let checkIsOk = requestWeather.requestDataServer(completion: { dataWeather in
            print(dataWeather)
            self.lbLocation.text = dataWeather.name
            self.lbDate.text = DateCurrent().convertTimeLongToDate(timeLong: dataWeather.dt)
            self.imgWeather.image = CheckImageWeather().checkImageWeather(description: dataWeather.weather[0].weatherDescription, timeLong: dataWeather.dt)
            self.lbTemp.text = String(Int(dataWeather.main.temp - 273.5))
            self.lbDescription.text = dataWeather.weather[0].weatherDescription
            self.lbTempp.text = String(Int(dataWeather.main.temp - 273.5))
            self.lbHumidy.text = String(dataWeather.main.humidity)
            self.lbWind.text = String(dataWeather.wind.speed)
            
            
        }, completionError: { checkIsOk in
            if (checkIsOk == false) {
                let alert = UIAlertController(title: "Error: No Resuld \(self.textSearchChangle)", message: "You need write city no space", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    if (action.style == .default) {
                        // duyet qua ten cac thanh pho co trong danh sach:
                        
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "cancle", style: .cancel, handler: { action in
                    if (action.style == .cancel) {
                        print("Cancle")
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }, nameCity: textSearchChangle)
        
        
        
    }
    
    @IBAction func btActionCancle(_ sender: Any) {
        
        // vẫn luu lại giá trị đã seach trước đó:
        txtSearch.text = ""
        self.dataWeatherSearch = nil
       
        
    }
    
    
    func loadDataToSearch() {
        txtSearch.backgroundColor = UIColor.myGrayContent
        txtSearch.textColor = UIColor.white
        txtSearch.layer.cornerRadius = 20
        txtSearch.clipsToBounds = true
        txtSearch.font = UIFont(name: "lato", size: 30)
        txtSearch.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height:txtSearch.frame.height))
        txtSearch.leftViewMode = .always
        
        
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let searchText  = txtSearch.text! + string
        textSearchChangle = txtSearch.text! + string
        print(textSearchChangle)
        return true
    }
}

