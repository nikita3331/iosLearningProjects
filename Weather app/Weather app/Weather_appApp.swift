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
    @StateObject var locations = Locations()

    var body: some Scene {
        WindowGroup {

//                NavigationView{
//                    WeatherView(weather:weather)
//                }.tabItem {
//                    Image(systemName:"airplane.circle.fill")
//                    Text("Discover")
//                }
            NavigationView{
                WorldView(locations:locations)
            }
            .environmentObject(weather)
            .tabItem {
                Image(systemName:"airplane.circle.fill")
                Text("Locations")
            }
            

            
        }
        
    }
}
