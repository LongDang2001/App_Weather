//
//  HomeCollectionViewCell.swift
//  AppWeather
//
//  Created by admin on 12/2/21.
//  Copyright © 2021 Long. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbDate.textColor = UIColor.white
        lbTemp.textColor = UIColor.white
        contentView.layer.cornerRadius = 30
        contentView.backgroundColor = UIColor.myGrayContent
        contentView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgWeather.image = nil
        lbDate.text = nil
        lbTemp.text = nil
    }

}
