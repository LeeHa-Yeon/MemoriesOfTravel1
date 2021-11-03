//
//  WeatherManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import Foundation

class WeatherManager{
    
    static let shared: WeatherManager = WeatherManager()
    
    private init(){}
    
    var iconName = String()
    var description = String()
    var nowTemp = Double()
    var tempMax = Double()
    var tempMin = Double()
    var humidity = Double()
    
    func getIconName() -> String {
        return iconName
    }
    
    func setIconName(_ iconName: String){
        self.iconName = iconName
    }
    
    func getDescription() -> String {
        return description
    }
    
    func setDescription(_ description: String){
        self.description = description
    }
    
    func getNowTemp() -> Double {
        return nowTemp
    }
    
    func setNowTemp(_ nowTemp: Double){
        var changeCelsius = Double()
        changeCelsius = nowTemp - 273.15
        self.nowTemp = changeCelsius
    }
    
    func getTempMax() -> Double {
        return tempMax
    }
    
    func setTempMax(_ tempMax: Double){
        var changeCelsius = Double()
        changeCelsius = tempMax - 273.15
        self.tempMax = changeCelsius
    }
    func getTempMin() -> Double {
        return tempMin
    }
    
    func setTempMin(_ tempMin: Double){
        var changeCelsius = Double()
        changeCelsius = tempMin - 273.15
        self.tempMin = changeCelsius
    }
    func getHumidity() -> Double {
        return humidity
    }
    
    func setHumidity(_ humidity: Double){
        self.humidity = humidity
    }
    
    

}

