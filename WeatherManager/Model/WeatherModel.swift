//
//  WeatherModel.swift
//  WeatherManager
//
//  Created by Burhan Kaynak on 31/01/2021.
//

import Foundation

struct WeatherModel {
    let temp: Double
    let description: String
    let minTemp: Double
    let maxTemp: Double
    let humidity: Int
    let feelsLike: Double
    let card: String
    
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    var minTempString: String {
        return String(format: "%.0f", minTemp)
    }
    var maxTempString: String {
        return String(format: "%.0f", maxTemp)
    }
    var humidityString: String {
        return String("\(humidity)%")
    }
    var feelsLikeString: String {
        return String(format: "%.0f", feelsLike)
    }
    var weatherCard: String {
        switch card {
        case "01d":
            return "clear";
        case "02d":
            return "partly-cloudy";
        case "03d","04d":
            return "cloudy";
        case "09d","10d":
            return "rain";
        case "11d":
            return "wind";
        case "13d":
            return "snow";
        case "50d":
            return "fog";
        case "01n":
            return "clear-night";
        case "02n","03n","04n":
            return "partly-cloudy-night";
        default:
            return "cloudy"
        }
    }
    var weatherBackground: String {
        switch weatherCard {
        case "clear":
            return "YellowColour";
        case "partly-cloudy":
            return "BlueColour";
        case "cloudy":
            return "LightBlueColour2";
        case "rain":
            return "LightBlueColour";
        case "wind":
            return "PurpleColour";
        case "snow":
            return "LightBlueColour";
        case "fog":
            return "LightBlueColour";
        case "clear-night":
            return "DarkBlueColour";
        case "partly-cloudy-night":
            return "DarkBlueColour";
        default:
            return "cloudy"
        }
    }
}
