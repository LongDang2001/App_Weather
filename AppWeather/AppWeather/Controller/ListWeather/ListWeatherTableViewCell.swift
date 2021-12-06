//
//  ListWeatherTableViewCell.swift
//  AppWeather
//
//  Created by admin on 12/4/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class ListWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbDayOfWeak: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.myviewBackground
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}


