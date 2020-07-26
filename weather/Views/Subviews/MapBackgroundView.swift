//
//  WeatherReportView.swift
//  weather
//
//  Created by David Rozmajzl on 7/23/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import MapKit

struct MapBackgroundView: View {
    
    var latitude: Float?
    var longitude: Float?
    
    var body: some View {
        GeometryReader {geometry in
            VStack{
                HStack {
                    VStack (alignment: .leading) {
                        Text("Weather Report")
                            .font(.system(size: geometry.size.width * 0.15, weight: .heavy))
                            .foregroundColor(.white)
                            .lineSpacing(0)
                        
                        Text("Daily Forecast")
                            .font(.system(size: geometry.size.width * 0.05, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        
                    }
                    
                    Spacer()
                    
                }
                Spacer()
            }
            
        }
        .padding()
        .background(
            MapView(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude ?? 74.0060), longitude: CLLocationDegrees(longitude ?? 40.7128)))
                .saturation(0.0)
                .colorMultiply(.blue)
        )
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.horizontal)
    }
}
