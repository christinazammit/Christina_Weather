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
            Text("⛅️")
                .font(.system(size: 70))
                .padding()
            Text(viewModel.name)
                .font(.system(size: 30))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.country)
                .font(.system(size: 30))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.temp_c)
                .font(.system(size: 50))
                .bold()
                .padding()
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.feelslike_c)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.wind_kph)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.wind_dir)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.humidity)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.uv)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            Text(viewModel.vis_km)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 77 / 255, green: 77 / 255, blue: 77 / 255))
            
        }.onAppear(perform: viewModel.refresh)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 227 / 255, green: 248 / 255, blue: 255 / 255)]), startPoint: .top, endPoint: .bottom)).edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherModel(locationHelper: LocationHelper()))
    }
}
