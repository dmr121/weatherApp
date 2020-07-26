//
//  ImageIconView.swift
//  beerApp
//
//  Created by David Rozmajzl on 7/20/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import Combine

struct IconView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var icon: String?
    let size: iconSize
    
    var body: some View {
        Image(systemName: weatherIcons[icon ?? "loading"] ?? "goforward")
            .font(size == .large ? .largeTitle : .body)
            .foregroundColor(.gray)
            
    }
    
    let weatherIcons = [
        "01d": "sun.max.fill",
        "02d": "cloud.sun.fill",
        "03d": "cloud.fill",
        "04d": "smoke.fill",
        "09d": "cloud.drizzle.fill",
        "10d": "cloud.rain.fill",
        "11d": "cloud.bolt.rain.fill",
        "13d": "snow",
        "50d": "cloud.fog.fill",
        "01n": "moon.stars.fill",
        "02n": "cloud.moon.fill",
        "03n": "cloud.fill",
        "04n": "smoke.fill",
        "09n": "cloud.drizzle.fill",
        "10n": "cloud.rain.fill",
        "11n": "cloud.bolt.rain.fill",
        "13n": "snow",
        "50n": "cloud.fog.fill",
        "loading" : "goforward",
        "wind" : "wind",
        "sunrise" : "sunrise.fill",
        "sunset" : "sunset.fill",
    ]
    
}

extension IconView {
    enum iconSize {
        case small
        case large
    }
}
