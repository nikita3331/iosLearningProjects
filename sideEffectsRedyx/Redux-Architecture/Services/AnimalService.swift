//
//  AnimalService.swift
//  Redux-Architecture
//
//  Created by Daniel Bernal on 8/2/20.
//

import Foundation
import Combine

struct AnimalService {

    var requestNumber: Int = 0
    
    func generateAnimalInTheFuture() -> AnyPublisher<String, Never> {
        let animals = ["Cat", "Dog", "Crow", "Horse", "Iguana", "Cow", "Racoon"]
        let number = Double.random(in: 0..<5)
        return Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + number) {
                let result = animals.randomElement() ?? ""
                print("Animal: \(result)")
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    func fetchWeatherAnimals() -> AnyPublisher<String, Never> {
        var lat:Double=55.22;
        var lon:Double=55.22;
        let apiKey="04d9dec8176e4069b9d172635210204"

        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(lat),\(lon)&days=3&aqi=no")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        print("fetching animals")
        return Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                URLSession.shared.dataTask(with: request) { data, response, error in
                    let JSON = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    if let dictionary = JSON as? [String: Any],
                       let values = dictionary["current"] as? [String: Any]
                    {
                        if var dum=values["feelslike_c"] as? NSNumber{
                            DispatchQueue.main.async {
                                promise(.success(dum.stringValue))
                            }
                        }
                    }

                }.resume()
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}
