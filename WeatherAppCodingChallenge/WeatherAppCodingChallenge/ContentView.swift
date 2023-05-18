//
//  ContentView.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import SwiftUI
import UIKit
import CoreData
import CoreLocation

struct ContentView: View  {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var weatherViewModel = WeatherViewModel()
    @State private var text = ""
    
    // Grab most recent
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.date)
        ]
    ) var cityNames: FetchedResults<LastSearched>
    
    var body: some View {
        VStack{
            HStack {
                SearchBar(text: $text)
                Button(action: {
                    weatherViewModel.getWeatherByCity(city: text)
                    // Not functional error handling, would fix with time
                    if(!weatherViewModel.getErrorOccured()) {
                        let lastSearch = LastSearched(context: viewContext)
                        lastSearch.cityName = text
                        PersistenceController.shared.save()
                    } 
                }, label: {
                    Label("", systemImage: "plus.magnifyingglass").foregroundColor(.gray).font(.system(size: 30))
                })
            }
            MainWeatherView(weatherViewModel: weatherViewModel)
                .padding()
            Button(action: {
                weatherViewModel.getWeatherByLocation()
                let lastSearch = LastSearched(context: viewContext)
                lastSearch.cityName = weatherViewModel.getCityName()
                PersistenceController.shared.save()
            }, label: {
                Text("Local Weather")
            })
            .buttonStyle(.bordered)
            Spacer()
        }
        .onAppear() {
            weatherViewModel.requestLocation()
            //If no prev search load default
            if !cityNames.isEmpty {
                weatherViewModel.getWeatherByCity(city: cityNames[cityNames.endIndex - 1].cityName ?? "Plano")
            } else {
                weatherViewModel.getWeatherByLocation()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
