//
//  WeatherViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    var weather: Weather?
    var main: Main?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // data fetch
        WeatherService().getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setWeatherUI()
                }
            case .failure(_ ):
                print("error22")
            }
        }
    }

    
    //MARK: - 만든 아이콘 대입하는 부분
    private func setWeatherUI() {
        var weatherIcon:String = "01d"
        weatherIcon = self.weather!.icon
        if weatherIcon == "01d"{
            weatherImg.image = UIImage(named: "01d")
        }
        else if weatherIcon == "01n"{
            weatherImg.image = UIImage(named: "01n")
        }
        else if weatherIcon == "02d"{
            weatherImg.image = UIImage(named: "02d")
        }
        else if weatherIcon == "02n"{
            weatherImg.image = UIImage(named: "02n")
        }
        else if weatherIcon == "03d" || weatherIcon == "03n" {
            weatherImg.image = UIImage(named: "03")
        }
        else if weatherIcon == "04d" || weatherIcon == "04n" {
            weatherImg.image = UIImage(named: "04")
        }
        else if weatherIcon == "09d" || weatherIcon == "09n"{
            weatherImg.image = UIImage(named: "09")
        }
        else if weatherIcon == "10d"{
            weatherImg.image = UIImage(named: "10d")
        }
        else if weatherIcon == "10n"{
            weatherImg.image = UIImage(named: "10n")
        }
        else if weatherIcon == "11d" || weatherIcon == "11n"{
            weatherImg.image = UIImage(named: "11")
        }
        else if weatherIcon == "13d" || weatherIcon == "13n"{
            weatherImg.image = UIImage(named: "13")
        }
        else if weatherIcon == "50d" || weatherIcon == "50n"{
            weatherImg.image = UIImage(named: "50")
        }

        

    }
    
    //MARK: - 원래 날씨 아이콘을 받아오는 방식 ( 아이콘이 맘에 안들어서 난 다시 만듬 )
//    private func setWeatherUI() {
//        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
//        let data = try? Data(contentsOf: url!)
//        if let data = data {
//            weatherImg.image = UIImage(data: data)
//
//        }
//
//    }
    
}
