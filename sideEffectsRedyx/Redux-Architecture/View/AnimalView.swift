//
//  AnimalView.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 7/30/20.
//

import SwiftUI

struct AnimalView: View {
    @EnvironmentObject var store: AppStore
    
    func loadAnimal() {
        store.dispatch(.animal(action: .fetchAnimal))
        store.dispatch(.animal(action: .fetchWeatherAnimal))
        print()
    }

    var body: some View {
        VStack {
            Text(store.state.animal.weatherAnimal).font(.system(.largeTitle)).padding()
//            Text(store.state.animal.currentAnimal).font(.system(.largeTitle)).padding()
            Button("Tap me", action: { self.loadAnimal() })
        }
    }
}
