//
//  Weather.swift
//  weather
//
//  Created by David Rozmajzl on 7/22/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import Foundation

struct Weather: Codable, Identifiable {
    var name: String?
    var id: Int?
    var coord: Coordinates?
    var weather: [Conditions]?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var rain: Rain?
    var snow: Snow?
    var clouds: Cloud?
    var dt: Int?
    var sys: Sys?
    var timezone: Int?
}

struct Coordinates: Codable {
    var lon: Float?
    var lat: Float?
}

struct Conditions: Codable, Identifiable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Codable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Float?
    var humidity: Float?
    var sea_level: Float?
    var grnd_level: Float?
}

struct Wind: Codable {
    var speed: Float?
    var deg: Float?
    var gust: Float?
}

struct Rain: Codable {
    var lastHour: Float?
    var last3Hours: Float?
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case last3Hours = "3h"
    }
}

struct Snow: Codable {
    var lastHour: Float?
    var last3Hours: Float?
    
    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case last3Hours = "3h"
    }
}

struct Cloud: Codable {
    var percentage: Int?
    
    private enum CodingKeys: String, CodingKey {
        case percentage = "all"
    }
}

struct Sys: Codable {
    var country: String?
    var sunrise: Int?
    var sunset: Int?
    
    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let countryCode = try? container.decode(String.self, forKey: .country) {
            country = countryCodeToFullName(code: countryCode)
        } else {
            country = nil
        }
        sunrise = try? container.decode(Int.self, forKey: .sunrise)
        sunset = try? container.decode(Int.self, forKey: .sunset)
    }
    
    func countryCodeToFullName(code: String?) -> String? {
        guard code != nil else {return nil}
        let current = Locale(identifier: "en_US")
        let country = current.localizedString(forRegionCode: code!)
        return country
    }
}
