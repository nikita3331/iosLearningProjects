//
//  Weather_appApp.swift
//  Weather app
//
//  Created by Mykyta Brazhynskyy on 30/03/2021.
//

import SwiftUI

@main
struct Weather_appApp: App {
    @StateObject var weather = Weather()
    var body: some Scene {
        WindowGroup {
            TabView{
                NavigationView{
                    ContentView(weather:weather)
                }.tabItem {
                    Image(systemName:"airplane.circle.fill")
                    Text("Discover")
                }

            }.environmentObject(weather)
        }
        
    }
}
