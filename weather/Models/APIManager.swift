//
//  APIManager.swift
//  weather
//
//  Created by David Rozmajzl on 7/22/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation

class APIManager {
    private let apiAddress = "https://api.openweathermap.org/data/2.5/weather"
    
    public func getWeather(latitude: Double, longitude: Double, completion: @escaping (Weather) -> ()) {
        guard let url = URL(string: "\(apiAddress)?lat=\(latitude)&lon=\(longitude)&APPID=\(Secret.APPID)") else {return}
        
        print("Start API Fetch")
        URLSession.shared.dataTask(with: url){ data, response, error_ in
            if let error = error_ {
                print("API Request Error: \(error.localizedDescription)")
            } else {
                if let data = data {
                    do {
                        print("End API Fetch")
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        print(weather)
                        
                        DispatchQueue.main.async {
                            completion(weather)
                        }
                        
                    } catch {
                        print("JSON Decoding Error: \(error.localizedDescription)")
                    }
                }
            }
        }.resume()
    }
}
