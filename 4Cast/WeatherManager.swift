//
//  WeatherManager.swift
//  4Cast
//
//  Created by Dylan MacFarlane on 12/10/19.
//  Copyright © 2019 Dylan MacFarlane. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject, LocationFetcherDelegate {
    let locationFetcher = LocationFetcher()
    func didUpdateLocation(_ locationAt: LocationFetcher, location: CLLocationCoordinate2D) {
        fetchLocation()
    }
    
    
    
    
    @Published var temp = ""
    @Published var weatherIcon = 1
    @Published var locationData = "City"
    @Published var iconData = "sun.min"
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=930d32b308327670a0c4d78fd301fcd2&units=imperial"
    
    init() {
        locationFetcher.delegate = self
    }
    
    func fetchLocation() {
        let lat = locationFetcher.lastKnownLocation?.latitude
        let lon = locationFetcher.lastKnownLocation?.longitude
        let formattedString = "\(weatherURL)&lat=\(lat!)&lon=\(lon!)"
        fetch(formattedString: formattedString)
    }
    
    func fetchWeather(cityname: String) {
        let formattedName = cityname.replacingOccurrences(of: " ", with: "+")
        let formattedString = "\(weatherURL)&q=\(formattedName)"
        fetch(formattedString: formattedString)
    }
        
    func fetch(formattedString: String) {
        if let url = URL(string: formattedString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let environmentalData = try decoder.decode(WeatherData.self, from: safeData)
                            self.temp = "\(environmentalData.main.temp)"
                            self.weatherIcon = environmentalData.weather[0].id
                            self.locationData = "\(environmentalData.name)"
                            
                            var iconWeather: String {
                                switch self.weatherIcon {
                                case 200...232:
                                    return "cloud.bolt"
                                case 300...321:
                                    return "cloud.drizzle"
                                case 500...531:
                                    return "cloud.rain"
                                case 600...622:
                                    return "snow"
                                case 701...781:
                                    return "sun.haze"
                                case 800:
                                    return "sun.max"
                                case 801...804:
                                    return "cloud"
                                default:
                                    return "sun.min"
                                }
                            }
                            self.iconData = iconWeather
                            
                            
                            
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
}
