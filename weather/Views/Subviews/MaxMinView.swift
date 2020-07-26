//
//  MaxMinView.swift
//  weather
//
//  Created by David Rozmajzl on 7/24/20.
//  Copyright © 2020 David Rozmajzl. All rights reserved.
//

import SwiftUI

struct MaxMinView: View {
    
    var max: Float?
    var min: Float?
    var unitSystem: Unit
    
    var body: some View {
        HStack {
            
            VStack {
                Text("")
                .hidden()
            }
            .frame(width: 3, height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .bottom, endPoint: .top))
            .cornerRadius(10)
            
            VStack (spacing: 14){
                Text(max != nil ? // Make sure temp isn't nil
                    (unitSystem == .F ? kelvinToFarenheit(max!) : kelvinToCelcius(max!)) // Check whether we want F or C
                    : "°") // Print this if temp does happen to be nil
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
                
                Text(min != nil ? // Make sure temp isn't nil
                    (unitSystem == .F ? kelvinToFarenheit(min!) : kelvinToCelcius(min!)) // Check whether we want F or C
                    : "°") // Print this if temp does happen to be nil
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                
            }
        }
    }
}

extension MaxMinView {
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
