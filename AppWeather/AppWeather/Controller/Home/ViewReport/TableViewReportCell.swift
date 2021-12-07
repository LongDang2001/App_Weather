//
//  TableViewReportCell.swift
//  AppWeather
//
//  Created by admin on 12/7/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class TableViewReportCell: UITableViewCell {

    @IBOutlet weak var contentViews: UIView!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTem: UILabel!
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.myviewBackground
        contentViews.backgroundColor = UIColor.myGrayContent
        contentViews.layer.cornerRadius = CGFloat(20)
        contentView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
