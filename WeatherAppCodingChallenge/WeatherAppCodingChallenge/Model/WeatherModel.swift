//
//  WeatherInfo.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import Foundation

// Auto Mark Model Segments incase expansion
// MARK: - WeatherModel
struct WeatherModel: Codable, Identifiable {
    var coord: Coord
    // weather comes in a list form for hourly info/updates, but with the free API service weather will only contain 1 Weather obj
    var weather: [Weather]
    var base: String
    var main: Temp
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var id: Int
    var name: String
    var cod: Int
    
    init() {
        coord = Coord(lon: 0.0, lat: 0.0)
        weather = [Weather(id: 0, main: "main", description: "desc", icon: "01d")]
        base = ""
        main = Temp(temp: 0.0, pressure: 0, humidity: 0, tempMin: 0.0, tempMax: 0.0)
        visibility = 0
        wind = Wind(speed: 0.0, deg: 0)
        clouds = Clouds(all: 0)
        dt = 0
        sys = Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0)
        id = 0
        name = ""
        cod = 0
    }
    
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double
}

// MARK: - Temp
struct Temp: Codable {
    var temp: Double
    var pressure, humidity: Int
    var tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int
    var country: String
    var sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double
    var deg: Int
}
