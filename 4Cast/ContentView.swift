//
//  ContentView.swift
//  4Cast
//
//  Created by Dylan MacFarlane on 12/3/19.
//  Copyright © 2019 Dylan MacFarlane. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherManager = WeatherManager()
    
    @State var cityName = ""
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.weatherManager.fetchLocation()
                            
                            
                        }) {
                            Image(systemName: "globe")
                            .resizable()
                            .frame(width: 24, height: 25, alignment: .center)
                            .foregroundColor(.init("textcolor"))
                        }
                        TextField("Enter city name", text: $cityName)
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 9.0)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.gray)
                                    .opacity(0.17)
                        )
                        Button(action: {
                            self.weatherManager.fetchWeather(cityname: self.cityName)
                            
                            
                        }) {
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.init("textcolor"))
                        }
                        Spacer()
                    }
                    VStack(spacing: -3.0) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            HStack {
                                Spacer()
                                Image(systemName: weatherManager.iconData)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 80, idealWidth: 150, maxWidth: 400, minHeight: 80, idealHeight: 150, maxHeight: 400, alignment: .trailing)
                                    .foregroundColor(.init("textcolor"))
                            }
                        }
                        .padding(.vertical, 6.0)
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            HStack {
                                Spacer()
                                Text("\(weatherManager.temp)°F")
                                    .font(.system(size: 70))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.init("textcolor"))
                            }
                        }
                        .padding(.vertical, 5.0)
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)

                            HStack {
                                Spacer()
                                Text("\(weatherManager.locationData)")
                                    .font(.system(size: 40))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.init("textcolor"))
                                    .lineLimit(1)
                            }
                        }
                        .padding(.vertical, 5.0)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                }
                .padding()
                Spacer()
            }
        }
        .background(
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
