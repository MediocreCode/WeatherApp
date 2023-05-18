//
//  WeatherAppCodingChallengeApp.swift
//  WeatherAppCodingChallenge
//
//  Created by m_959053 on 5/17/23.
//

import SwiftUI

// TODO - Location, CoreData, Design, more detail

@main
struct WeatherAppCodingChallengeApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
