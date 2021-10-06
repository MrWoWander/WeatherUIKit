//
//  CityTableViewCell.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 06.10.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    var cityName: String? {
        didSet {
            cityNameLabel.text = cityName
        }
    }
    var temp: String? {
        didSet {
            tempCityLabel.text = temp
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
