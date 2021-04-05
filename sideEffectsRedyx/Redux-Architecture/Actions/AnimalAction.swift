//
//  AnimalAction.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation

enum AnimalAction {
    case fetchAnimal
    case logAnimal
    case setCurrentAnimal(animal: String)
    case setWeatherAnimal(weather: String)
    case fetchWeatherAnimal
    
}
