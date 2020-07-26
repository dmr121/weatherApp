//
//  MainContentView.swift
//  weather
//
//  Created by David Rozmajzl on 7/23/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct MainInformationView: View {
    var weather: Conditions?
    var temps: Main?
    var rain: Rain?
    var wind: Wind?
    var snow: Snow?
    var clouds: Cloud?
    
    // MARK: Implement units conversion
    var unitSystem: Unit
    
    init(data: Weather, units: Unit = .F) {
        self.weather = data.weather?[0]
        temps = data.main
        rain = data.rain
        snow = data.snow
        wind = data.wind
        clouds = data.clouds
        unitSystem = units
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack (spacing: 12) {
                    IconView(icon: weather?.icon, size: .large)
                    
                    Text(weather?.description?.capitalized ?? "...")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(.gray)
                    
                }
                
                Spacer()
                
                VStack (alignment: .trailing){
                    Text(temps?.temp != nil ? // Make sure temp isn't nil
                        (unitSystem == .F ? kelvinToFarenheit(temps!.temp!) : kelvinToCelcius(temps!.temp!)) // Check whether we want F or C
                        : "...") // Print this if temp does happen to be nil
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text(temps?.feels_like != nil ? // Make sure temp isn't nil
                        (unitSystem == .F ? "Feels Like: \(kelvinToFarenheit(temps!.feels_like!))" : "Feels Like: \(kelvinToCelcius(temps!.feels_like!))") // Check whether we want F or C
                        : "...") // Print this if temp does happen to be nil
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(.gray)
                    
                }
                
                MaxMinView(max: temps?.temp_max, min: temps?.temp_min, unitSystem: unitSystem)
                
            }
            .padding([.top, .trailing])
            .padding(.leading, 24)
            
            HStack {
                VStack (alignment: .leading) {
                    if clouds != nil {
                        HStack {
                            IconView(icon: "04d", size: .small)
                            Text("\(clouds!.percentage ?? 0)% Cloudy")
                            .foregroundColor(.gray)
                            .font(.system(.callout, design: .rounded))
                        }
                    }
                    
                    if wind != nil {
                        HStack {
                            IconView(icon: "wind", size: .small)
                            Text("\(String(format: "%.1f", wind?.speed ?? 0)) M/s Wind Speed")
                            .foregroundColor(.gray)
                            .font(.system(.callout, design: .rounded))
                        }
                    }
                    
                    if rain != nil {
                        HStack {
                            IconView(icon: "10d", size: .small)
                            Text("\(String(format: "%.1f", rain?.lastHour ?? 0)) cm Rain")
                            .foregroundColor(.gray)
                            .font(.system(.callout, design: .rounded))
                        }
                    }
                    
                    if snow != nil {
                        HStack {
                            IconView(icon: "13d", size: .small)
                            Text("\(String(format: "%.1f", snow?.lastHour ?? 0)) cm Snow")
                                .foregroundColor(.gray)
                            .font(.system(.callout, design: .rounded))
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
            }
            
        }
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        
    }
}

extension MainInformationView {
    func kelvinToFarenheit(_ temp: Float) -> String{
        let farenheit = (temp - 273.15) * 9/5 + 32
        let farenheitString = String(format: "%.0f°", farenheit)
        return farenheitString
    }
    
    func kelvinToCelcius(_ temp: Float) -> String {
        let celcius = temp - 273.15
        let celciusString = String(format: "%.0f°", celcius)
        return celciusString
    }
}
