//
//  CityDetailViewController.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 07.10.2021.
//

import UIKit

class CityDetailViewController: UIViewController {

    var cityInfo: WeathModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = cityInfo?.city
        
        // Do any additional setup after loading the view.
    }

}
