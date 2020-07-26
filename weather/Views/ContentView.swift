//
//  ContentView.swift
//  weather
//
//  Created by David Rozmajzl on 7/22/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var location = LocationManager()
    @State var unit: Unit = .F
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                UnitToggle(unit: self.$unit)
                    .padding(.horizontal)
                
                MapBackgroundView(latitude: self.location.weather.coord?.lat, longitude: self.location.weather.coord?.lon)
                    .frame(maxHeight: .infinity)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text(self.location.weather.name ?? "Loading Name")
                            .font(.system(size: geometry.size.width * 0.06, weight: .bold, design: .rounded))
                            .foregroundColor(.blue)
                        
                        Text(self.location.weather.sys?.country ?? "Loading Country")
                            .font(.system(size: geometry.size.width * 0.04, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                
                MainInformationView(data: self.location.weather, units: self.unit)
                    .padding(.horizontal)
                
                SunriseSetView(weather: self.location.weather)
                    .padding(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UnitToggle: View {
    @Binding var unit: Unit
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
            Button(action: {
                if self.unit == .F {
                    self.unit = .C
                } else {
                    self.unit = .F
                }
            }) {
                HStack {
                    Image(systemName: self.unit == .F ? "f.circle.fill" : "f.circle")
                    Image(systemName: self.unit == .F ? "c.circle" : "c.circle.fill")
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            
            }
            
        }
    }
}
