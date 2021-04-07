//
//  Weather.swift
//  Weather app
//
//  Created by Mykyta Brazhynskyy on 03/04/2021.
//

import Foundation
struct gamePlayer {
    var name:String
}
class Weather :ObservableObject{

    var lat:Double=55.22;
    var lon:Double=55.22;
    
    var playerNames:[String]=[]
    var gamePlayers:[ gamePlayer]=[]
    
    @Published var myTemperature:Double=0.0;
    @Published var isLoading:Bool=false;

    let apiKey="04d9dec8176e4069b9d172635210204"
    func fetchWeather(lat:Double,lon:Double,completion: (() -> Void)? = nil){
        self.isLoading=true
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
                        self.isLoading=false
                    }
                    DispatchQueue.global().async {
                        completion?()
                    }
                }
            }

        }.resume()
    }
    func fetchNewWeather(lat:Double,lon:Double,completionBlock: @escaping (Double) -> Void){
        self.isLoading=true
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(lat),\(lon)&days=3&aqi=no")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            let JSON = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            if let dictionary = JSON as? [String: Any],
               let values = dictionary["current"] as? [String: Any]
            {
                if var dum=values["feelslike_c"] as? NSNumber{
                    completionBlock(dum.doubleValue);
                }
            }

        }.resume()
    }
    func coolDispatchFunction() {
        print("entering group")
       let group = DispatchGroup()
       group.enter()
        fetchNewWeather(lat:lat,lon:lon){
            (output) in
            print("tutaj",output)
            self.myTemperature=output
            group.leave()
            print("leave group")
        }
        DispatchQueue.main {
            self.myTemperature=output
            self.isLoading=false
        }
        group.wait()

        print("nowy out",self.myTemperature)



       //anything after this point won't execute until we get a result from someAsyncFunction()
    }

    init(){
        fetchWeather(lat: lat, lon: lat,completion:{print("finished")})
        coolDispatchFunction()
    }
}


