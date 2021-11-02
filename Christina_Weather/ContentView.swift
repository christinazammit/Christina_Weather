//
//  ContentView.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Mississauga")
                .font(.largeTitle)
                .padding()
            Text("Canada")
                .font(.largeTitle)
                .padding()
            Text("10ºC")
                .font(.system(size: 70))
                .bold()
            Text("☁️")
                .font(.largeTitle)
                .padding()
            Text("Feels like 5ºC")
                .font(.system(size: 25))
            Text("Wind speeds: 13kph")
                .font(.system(size: 25))
            Text("Wind direction: WSW")
                .font(.system(size: 25))
            Text("Humidity: 53")
                .font(.system(size: 25))
            Text("UV: 1.0")
                .font(.system(size: 25))
            Text("Visibility: 14km")
                .font(.system(size: 25))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
