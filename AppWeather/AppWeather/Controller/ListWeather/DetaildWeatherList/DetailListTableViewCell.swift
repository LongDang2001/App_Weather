//
//  DetailListTableViewCell.swift
//  AppWeather
//
//  Created by admin on 12/8/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {

    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var lbdate: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbTem: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbHumidy: UILabel!
    @IBOutlet weak var lbWind: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.myviewBackground
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
