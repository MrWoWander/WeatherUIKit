//
//  CitisTableViewController.swift
//  WeatherUIKit
//
//  Created by Mikhail Ivanov on 06.10.2021.
//

import UIKit

class CitisTableViewController: UITableViewController {

    var weath: WeathInteractor = WeathInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weath.city.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)

        if let cityCell = cell as? CityTableViewCell {
            cityCell.cityName = weath.city[indexPath.row].city
            
            let temp = weath.city[indexPath.row].fact.temp
            cityCell.temp = temp > 0 ? "+\(temp)°C" : "\(temp)°C"
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "cityDetailedInfo", sender: indexPath)
    }
    
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        
       let alert =  UIAlertController(title: "Выбрать город", message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            $0.placeholder = "Название города"
        }
        
        let alertOk = UIAlertAction(title: "Добавить", style: .default) {[weak self] _ in
            
            if let city = alert.textFields?.first?.text {
                self?.weath.fetchWeath(city: city) {[weak self] _ in
                    print("Done")
                    self?.tableView.reloadData()
                }
            }
        }
        
        let alertCancale = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(alertOk)
        alert.addAction(alertCancale)
        
        present(alert, animated: true, completion: nil)
    }
}


extension CitisTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cityDetailedInfo",
           let indexPath = sender as? IndexPath,
           let vc = segue.destination as? CityDetailViewController {
            vc.cityInfo = self.weath.city[indexPath.row]
        }
    }
}
