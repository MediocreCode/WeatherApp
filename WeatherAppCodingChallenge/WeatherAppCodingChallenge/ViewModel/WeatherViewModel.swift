//
//  WeatherViewModel.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import Foundation
import CoreLocation
import SwiftUI

final class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var weatherReport = WeatherModel()
    // Wanted to utilize this more
    var errorOccured: Bool = false
    @Published var userLocation = CLLocationCoordinate2D()
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func getWeatherByCity(city: String) {
      errorOccured = apiCall().getInfoByCity(city: city) {
            info in self.weatherReport = info
        }
    }

    func getWeatherByCoords(lat: Double, lon: Double) {
        errorOccured = apiCall().getInfoByCoords(lon: lon, lat: lat) {
            info in self.weatherReport = info
        }
    }
    
    func getWeatherByLocation() {
        requestLocation()
        errorOccured = apiCall().getInfoByCoords(lon: userLocation.longitude, lat: userLocation.latitude) {
            info in self.weatherReport = info
        }
    }
    
    // Could be improved
    func getWeatherIcon() -> String {
        return "https://openweathermap.org/img/wn/\(weatherReport.weather[0].icon)@4x.png"
    }
    
    func getCityName() -> String {
        return weatherReport.name
    }
    
    func getDesc() -> String {
        return weatherReport.weather[0].description.capitalized
    }
    
    func getTemp() -> String {
        return String(format: "%.1f°F",(weatherReport.main.temp - 273.15) * 9/5 + 32)
    }
    
    func getCountryName() -> String {
        return weatherReport.sys.country
    }
    
    func setError(bool: Bool) {
        errorOccured = bool
    }
    
    func getErrorOccured() -> Bool {
        return errorOccured
    }
    
    // MARK: - Location Manager Functionality

    func requestLocation() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
        userLocation = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 40.755840, longitude: -73.976883)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            getWeatherByLocation()
        }
    
    func getLocation() -> CLLocationCoordinate2D {
        userLocation = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 40.755840, longitude: -73.976883)
        getWeatherByCoords(lat: userLocation.latitude, lon: userLocation.longitude)
        return userLocation
    }
    
    func getLocationName() -> String {
        userLocation = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 40.755840, longitude: -73.976883)
        getWeatherByCoords(lat: userLocation.latitude, lon: userLocation.longitude)
        return weatherReport.name
    }

    
}
