//
//  CityDetailViewController.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 07.10.2021.
//

import UIKit
import SVGKit
import MapKit

class CityDetailViewController: UIViewController {
    
    var cityInfo: WeathModel?
    
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var tempImageView: UIImageView!
        
    @IBOutlet weak var cityMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityInfo = cityInfo {
            navigationItem.title = cityInfo.city
            
            let temp = cityInfo.fact.temp
            let tempLike = cityInfo.fact.feelsLike
            
            if let coordinate = cityInfo.coordinate {
                
                let region = MKCoordinateRegion(
                      center: coordinate,
                      latitudinalMeters: 15000,
                      longitudinalMeters: 15000)
                
                cityMapView.setRegion(region, animated: true)
                cityMapView.isScrollEnabled = false
                cityMapView.isZoomEnabled = false
                cityMapView.isRotateEnabled = false
                cityMapView.isPitchEnabled = false
            } else {
                cityMapView.isHidden = true
            }
            tempLable.text = temp > 0 ? "+\(temp)°C" : "\(temp)°C"
            feelsLikeLabel.text = "Ощущается как: " + (tempLike > 0 ? "+\(tempLike)°C" : "\(tempLike)°C")
            
            downloadImage(weathModel: cityInfo)
        }
    }
    
    func downloadImage(weathModel: WeathModel) {
        if let svgURL = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weathModel.fact.icon).svg"),
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
