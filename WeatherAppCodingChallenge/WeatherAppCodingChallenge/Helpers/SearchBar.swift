//
//  SearchBar.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import Foundation
import UIKit
import SwiftUI

// Using UIKit as instructed, this means we will easyable be able to utilize UISearchBar in our View
// Future me here. This took longer than expected, ending up getting help from: https://dev.to/bsorrentino/how-to-use-uikit-search-bar-in-swiftui-for-ios-tvos-3bgm

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    private var placeholder: String = "Find a City..."
    
    init(text: Binding<String>) {
           _text = text
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
    
    class Cordinator : NSObject, UISearchBarDelegate {
        @Binding var text : String
        init(text : Binding<String>) {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
           return Cordinator(text: $text)
       }
    
}

