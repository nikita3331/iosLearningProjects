//
//  AnimalReducer.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation

func animalReducer(state: inout AnimalState, action: AnimalAction) -> Void {
    
    switch(action) {
        case .fetchAnimal:
            state.currentAnimal = "Loading..."
        case .setCurrentAnimal(let animal):
            state.currentAnimal = animal
        case .setWeatherAnimal(let weather):
            state.weatherAnimal = weather
        default: break;
    }
}
