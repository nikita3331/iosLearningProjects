//
//  Locations.swift
//  demoApp
// 
//  Created by Mykyta Brazhynskyy on 26/03/2021.
//

import Foundation
class Locations :ObservableObject{

    let places: [Location]
    var primary : Location{
        places[0]
    }
    init(){
        let url=Bundle.main.url(forResource: "locations", withExtension: "json")!
        print(url)
        print(url)
        let data=try!Data(contentsOf: url)
        places=try! JSONDecoder().decode([Location].self, from: data)
    }
}
