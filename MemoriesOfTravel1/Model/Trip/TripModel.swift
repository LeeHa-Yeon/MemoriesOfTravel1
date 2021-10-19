//
//  TripModel.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/18.
//

import Foundation

class TripModel{
    private var tripPK: String
    private var tripName: String
    private var tripFirstDay: String
    private var tripPeriod: String
    private var tripDate: String
    
    init(){
        self.tripPK = ""
        self.tripName = ""
        self.tripFirstDay = ""
        self.tripPeriod = ""
        self.tripDate = ""
    }

    func getTripPK() -> String {
        return self.tripPK
    }
    
    func setTripPK(_ tripPK: String){
        self.tripPK = tripPK
    }
    
    func getTripName() -> String {
        return self.tripName
    }
    
    func setTripName(_ tripName: String){
        self.tripName = tripName
    }
    
    func getTripFirstDay() -> String {
        return self.tripFirstDay
    }
    
    func setTripFirstDay(_ tripFirstDay: String){
        self.tripFirstDay = tripFirstDay
    }
    
    func getTripPeriod() -> String {
        return self.tripPeriod
    }
    
    func setTripPeriod(_ tripPeriod: String){
        self.tripPeriod = tripPeriod
    }
    
    func getTripDate() -> String {
        return self.tripDate
    }
    
    func setTripDate(_ tripDate: String){
        self.tripDate = tripDate
    }
}
