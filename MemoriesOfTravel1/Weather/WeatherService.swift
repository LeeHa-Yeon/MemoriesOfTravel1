//
//  WeatherService.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import Foundation

// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    var apiKey: String = "c40972bd95e2c39d1cbabc60bec6d3f4"
    var longitude: Double = 128.7384361
    var latitude: Double = 35.3959361
    
    func getWeather(completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)")
        
        // url 검사
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)

            // 성공
            if let weatherResponse = weatherResponse {
                print(weatherResponse)
                completion(.success(weatherResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 dataTask 시작
    }
}
