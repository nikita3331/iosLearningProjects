//
//  Weather.swift
//  Weather app
//
//  Created by Mykyta Brazhynskyy on 03/04/2021.
//

import Foundation
class Weather :ObservableObject{

    var lat:Double=55.22;
    var lon:Double=55.22;
    @Published var myTemperature:Double=22.4;
    let apiKey="04d9dec8176e4069b9d172635210204"
    func fetchWeather(lat:Double,lon:Double){
        print("going into weahter")
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(lat),\(lon)&days=3&aqi=no")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            let JSON = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let dictionary = JSON as? [String: Any],
               let values = dictionary["current"] as? [String: Any]
            {
                if var dum=values["feelslike_c"] as? NSNumber{
                    DispatchQueue.main.async {
                        self.myTemperature=dum.doubleValue
                    }
                    print(dum.floatValue)
                }
            }

        }.resume()
        


    }
    init(){
        fetchWeather(lat: lat, lon: lat)
    }
}


