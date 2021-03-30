//
//  ContentView.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 24/03/2021.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let location:Location
    var body: some View {
        ScrollView{
            Image(location.heroPicture)
                .resizable()
                .scaledToFit()
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

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabView{
            NavigationView{
                ContentView(location:Locations().primary)
            }.tabItem {
                Image(systemName:"airplane.circle.fill")
                Text("Halko")
            }
        }
    }
}
