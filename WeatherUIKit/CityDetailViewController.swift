//
//  CityDetailViewController.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 07.10.2021.
//

import UIKit
import SVGKit

class CityDetailViewController: UIViewController {
    
    var cityInfo: WeathModel?
    
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var tempImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityInfo = cityInfo {
            navigationItem.title = cityInfo.city
            
            let temp = cityInfo.fact.temp
            let tempLike = cityInfo.fact.feelsLike
            
            tempLable.text = temp > 0 ? "+\(temp)°C" : "\(temp)°C"
            feelsLikeLabel.text = "Ощущается как: " + (tempLike > 0 ? "+\(tempLike)°C" : "\(tempLike)°C")

            if let svgURL = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(cityInfo.fact.icon).svg"),
               let svgData = try? Data(contentsOf: svgURL),
               let svgImage = SVGKImage(data: svgData)
            {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    svgImage.size = self.tempImageView.bounds.size
                    
                    self.tempImageView.image = svgImage.uiImage
                }
            }
        }
    }
}
