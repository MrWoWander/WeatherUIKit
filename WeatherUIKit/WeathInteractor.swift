//
//  WeathInteractor.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 06.10.2021.
//

import Foundation
import CoreLocation

protocol WeathInteractorProtocol: NSObject {
    func fetchWeath(city: String, complition: @escaping (WeathModel) -> Void)
}

class WeathInteractor: NSObject, WeathInteractorProtocol {
    
    let apiKey = "00cd2fe1-c179-43f6-be7e-395b2834a820"
    
    var city: [WeathModel] = []
    
    func fetchWeath(city: String, complition: @escaping (WeathModel) -> Void) {
        CLGeocoder().geocodeAddressString(city) {[weak self] placemarkc, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let coordinate = placemarkc?.first?.location?.coordinate else {return}
            
            self?.fetchYandexReq(city: city, coordinate: coordinate, complition: complition)
        }
    }
    
    func fetchYandexReq(city: String, coordinate: CLLocationCoordinate2D, complition: @escaping (WeathModel) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.addValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
            
            let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    return
                }
                
                guard let data = data else {
                    print("HTTP response data is empty")
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Non-HTTP response")
                    return
                }
                
                print(response.statusCode)
                
                guard var weath = try? JSONDecoder().decode(WeathModel.self, from: data) else {
                    print("error")
                    return
                }
                
                weath.city = city
                weath.coordinate = coordinate
                
                DispatchQueue.main.async {
                    self?.city.append(weath)
                    
                    complition(weath)
                }
            }
            
            task.resume()
        }
    }
}
