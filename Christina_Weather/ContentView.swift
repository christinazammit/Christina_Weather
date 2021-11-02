//
//  ContentView.swift
//  Christina_Weather
//
//  Created by Christina Zammit on 2021-11-01.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherModel
    
    var body: some View {
        VStack {
            Text(viewModel.name)
                .font(.largeTitle)
                .padding()
            Text(viewModel.country)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temp_c)
                .font(.system(size: 70))
                .bold()
                .padding()
            Text(viewModel.feelslike_c)
                .font(.system(size: 25))
            Text(viewModel.wind_kph)
                .font(.system(size: 25))
            Text(viewModel.wind_dir)
                .font(.system(size: 25))
            Text(viewModel.humidity)
                .font(.system(size: 25))
            Text(viewModel.uv)
                .font(.system(size: 25))
            Text(viewModel.vis_km)
                .font(.system(size: 25))
        }.onAppear(perform: viewModel.refresh)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherModel(locationHelper: LocationHelper()))
    }
}
