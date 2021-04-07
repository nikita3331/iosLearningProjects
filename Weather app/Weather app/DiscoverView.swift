//
//  ContentView.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 24/03/2021.
//

import SwiftUI
import UIKit

struct DiscoverView: View {
    let location:Location
    @State private var selection: String? = nil
    @EnvironmentObject var weather: Weather
    func onButtonPress(){
        print("entering func")
        weather.fetchWeather(
            lat: location.latitude,
            lon: location.longitude,
            completion: {print("finished fetching")})
        selection="A"
    }
    var body: some View {
        ScrollView{
            ProgressView()
            Image(location.heroPicture)
                .resizable()
                .scaledToFit()
            NavigationLink(
                destination: WeatherView(),
                tag: "A",
                selection: $selection) { EmptyView() }

            Button(action: {

                onButtonPress()
            }, label: {
                Text("View temperature")
                    .padding(.all,10)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .background(Color.blue)
            })
            Text(location.name)
                .font(.largeTitle)
                .bold()
                .font(.title)
                .multilineTextAlignment(.center)
            Text(location.country)
                .font(.title)
                .foregroundColor(.secondary)
            Text(location.description)
                .padding(.horizontal,20)
            Text("Did you know?")
                .font(.title3)
                .bold()
                .padding(.top,10)
            Text(location.more)
        }
        .navigationTitle("Discover")
    }


}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            NavigationView{
                DiscoverView(location:Locations().primary)
            }.tabItem {
                Image(systemName:"airplane.circle.fill")
                Text("Halko")
            }
        }
    }
}
