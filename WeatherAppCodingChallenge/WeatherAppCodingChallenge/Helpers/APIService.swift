//
//  APIHelper.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import Foundation

enum APIError: Error {
    case invalidUrl, requestError, decodingError, statusNotOk
}

let BASE_URL: String = "https://api.openweathermap.org/data/2.5/weather?"

let API_KEY: String = "&appid=4a6e180f8ed72f3e22bda37d462caf3e"

class apiCall {
    
    //Retrieves weather info by city: String for SearchBar
    func getInfoByCity(city: String, completion:@escaping (WeatherModel) -> ()) -> Bool {
        var isError = false
        guard let url = URL(string: BASE_URL+"q=\(city)"+API_KEY) else { return true }
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                do {
                    let info = try JSONDecoder().decode(WeatherModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(info)
                    }
                } catch {
                    //Orginally I wanted to use this catch to change the searchBar placeholder to "City not found", but time constraints and complexity
                    isError = true
                    print("Decoding Error Has Occured")
                }
            }
            .resume()
            return isError
    }
    
    //Retrieves weather info by lat and lon for LocationManager
    func getInfoByCoords(lon: Double, lat: Double, completion:@escaping (WeatherModel) -> ()) -> Bool{
        var isError = false
        guard let url = URL(string: BASE_URL+"lat=\(lat)&lon=\(lon)"+API_KEY) else { return true }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let info = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(info)
                }
            } catch {
                isError = true
                print("Decoding Error Has Occured")
            }
        }
        .resume()
        return isError
    }
}

