//
//  ViewController.swift
//  WeatherManager
//
//  Created by Burhan Kaynak on 31/01/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherCard: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        weatherManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
    }
    
    @IBAction func currentLocationButtonTapped(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(manager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = weather.tempString
            self.weatherDescription.text = weather.description
            self.minTempLabel.text = weather.minTempString
            self.maxTempLabel.text = weather.maxTempString
            self.humidityLabel.text = weather.humidityString
            self.feelsLikeLabel.text = weather.feelsLikeString
            let weatherCard = weather.weatherCard
            let background = weather.weatherBackground
            self.weatherCard.image = UIImage(named: weatherCard)
            self.view.backgroundColor = UIColor(named: background)
        }
    }
    
    func didFailWithErrors(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Unable to find any results, please try again", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            textField.placeholder = "Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let selectedCity = searchTextField.text {
            let trimmed = selectedCity.replacingOccurrences(of: " ", with: "%20")
            weatherManager.fetchWeather(for: trimmed)
        }
        searchTextField.text = ""
    }
}
