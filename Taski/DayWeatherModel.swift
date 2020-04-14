//
//  File.swift
//  Animation
//
//  Created by Noura Aziz on 3/16/19.
//  Copyright © 2019 Noura Aziz. All rights reserved.
//

import Foundation
import UIKit

struct DayWeatherModel {
    var dayName = ""
    var longDate = ""
    var tempreture = ""
    var city = ""
    var weatherIcon: UIImage?
    
//    init(dayName: String, longDate: String, tempreture: String, city: String, weatherIcon: UIImage) {
//       self.dayName = dayName
//        self.longDate = longDate
//        self.tempreture = tempreture
//        self.city = city
//        self.weatherIcon = weatherIcon
//        
//    }
}
struct WeatherModel: Codable {
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Temp?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: CountryInfo?
    var timezone: Int?
    var id: Int?
    var name: String?
    var cod: Int?
}
struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Coordinates: Codable {
    var lon: Double?
    var lat: Double?
}
struct Temp: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
struct Clouds: Codable {
    var all: Int?
}
struct CountryInfo: Codable {
    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int? // d
    var sunset: Int? //d
}
//struct WeatherModel: Codable {

//    var images: [UIImage?]
//    var data1 = ""
//    var data2 = ""
//}
