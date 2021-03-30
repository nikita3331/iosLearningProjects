//
//  Location.swift
//  demoApp
//
//  Created by Mykyta Brazhynskyy on 25/03/2021.
//

import Foundation

struct Location: Decodable, Identifiable{
    let id:Int
    let name: String
    let country: String
    let description: String
    let more: String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let advisory: String
    
    static let example=Location(id: 1, name: "New highlands", country: "uk", description: "siemanko desc", more: "halo halo", latitude: 58.25, longitude: 25.77, heroPicture: "highlands", advisory: "siemaaan")
}

