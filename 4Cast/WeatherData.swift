//
//  WeatherData.swift
//  4Cast
//
//  Created by Dylan MacFarlane on 12/10/19.
//  Copyright © 2019 Dylan MacFarlane. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

