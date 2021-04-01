//
//  ContentView.swift
//  Weather app
//
//  Created by Mykyta Brazhynskyy on 30/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight=false
    let forecasts:[Forecast]=[
        Forecast(day: "MON", temp: 20, imageName: "cloud.sun.fill"),
        Forecast(day: "TUE", temp: 21, imageName: "sun.max.fill"),
        Forecast(day: "WED", temp: 22, imageName: "sunset.fill")
    ]
    var body: some View {
       
        ZStack{
            BackgroundView(isNight: $isNight)
            VStack{
                CityName(cityName: "Cupertino")
                CurrentWeather(iconName: "cloud.sun.fill", temperature: 31)
                HStack(spacing:100){
                    //add API call to get weather
                    ForEach(forecasts, id: \.day) {
                        forecast in
                            WeatherDayView(day: forecast.day, temp: forecast.temp,imageName: forecast.imageName)
                    }
                }
                Spacer()
                
                CustomButton(title: "Change day time",myAction:{isNight.toggle()})
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    let day:String
    let temp:Int
    let imageName:String
    var body: some View {
        VStack{
            Text(day)
                .foregroundColor(.white)
                .font(.system(size:28))
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temp)°C")
                .font(.system(size: 20,weight:.medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    @Binding var isNight:Bool
    var body: some View {
        let topColor=isNight ? Color.black : Color.blue
        let bottomColor=isNight ? Color.gray : Color("LightBlue")
        
        LinearGradient(gradient: Gradient(colors: [topColor,bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct CityName: View {
    var cityName:String
    var body: some View {
        Text(cityName)
            .font(.system(size: 30,weight:.bold))
            .foregroundColor(.white)
            .padding(.vertical,20)
    }
}

struct CurrentWeather: View {
    var iconName:String
    var temperature: Int
    var body: some View {
        VStack(spacing:2){
            Image(systemName: iconName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text("\(temperature)°C" )
                .font(.system(size: 70,weight:.medium))
                .foregroundColor(.white)
        }
        .padding(.bottom,40)
    }
}


