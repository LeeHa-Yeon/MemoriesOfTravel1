//
//  WeatherResponse.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import Foundation

struct WeatherResponse: Decodable{
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
