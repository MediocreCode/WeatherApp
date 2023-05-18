//
//  MainWeatherView.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import SwiftUI

struct MainWeatherView: View {
    @StateObject var weatherViewModel: WeatherViewModel
    
    // Simply top view that could be expanded on
    var body: some View {
        VStack {
            Text("\(weatherViewModel.getCityName()), \(weatherViewModel.getCountryName())")
                .font(.title2)
            AsyncImage(url: URL(string: weatherViewModel.getWeatherIcon()))
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
            Text("\(weatherViewModel.getDesc())")
                .font(.headline)
            Text(weatherViewModel.getTemp())
                .font(.title)
        }
    }
}

struct MainWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainWeatherView(weatherViewModel: WeatherViewModel())
    }
}
