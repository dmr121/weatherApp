//
//  SunriseSetView.swift
//  weather
//
//  Created by David Rozmajzl on 7/24/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct SunriseSetView: View {
    
    var sun: Sys?
    
    init(weather: Weather) {
        self.sun = weather.sys
    }
    
    var body: some View {
        HStack {
            VStack {
                IconView(icon: "sunrise", size: .large)
                
                if sun?.sunrise != nil {
                    Text(utcToSystemTime(time: (sun?.sunrise!)!))
                        .foregroundColor(.gray)
                        .font(.system(.callout, design: .rounded))
                        .padding(.top, 8)
                }
            }
            
            Spacer()
            
            VStack {
                IconView(icon: "sunset", size: .large)
                
                if sun?.sunset != nil {
                    Text(utcToSystemTime(time: (sun?.sunset!)!))
                        .foregroundColor(.gray)
                        .font(.system(.callout, design: .rounded))
                        .padding(.top, 8)
                }
            }
            
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal)
    }
}

extension SunriseSetView {
    func utcToSystemTime(time: Int) -> String {
        let fullDate = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let time = formatter.string(from: fullDate)
        return time
    }
}
