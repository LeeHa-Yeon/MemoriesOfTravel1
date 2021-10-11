//
//  Trip.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/11.
//

import Foundation
import UIKit

class Trip {
    // 여행지, 날짜 ,여행기간, 디데이,여행사진, 여행첫날
    private var tripPK: String
    private var tripName: String
    private var tripFirstDay: Date
    private var tripDate: String
    private var tripRange: Int
    private var tripDday: Int
    private var tripImage: String
    
    
    init(){
        self.tripPK = ""
        self.tripName = ""
        self.tripFirstDay  = Date()
        self.tripDate  = ""
        self.tripRange  = 0
        self.tripDday  = 0
        self.tripImage  = ""
        
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
    
    func getTripFirstDay() -> Date {
        return self.tripFirstDay
    }
    
    func setTripFirstDay(_ tripFirstDay: Date){
        self.tripFirstDay = tripFirstDay
    }
    
    func getTripDate() -> String {
        return self.tripDate
    }
    
    func setTripDate(_ tripDate: String){
        self.tripDate = tripDate
    }
    
    func getTripRange() -> Int {
        return self.tripRange
    }
    
    func setTripRange(_ tripRange: Int){
        self.tripRange = tripRange
    }
    
    func getTripDday() -> Int {
        return self.tripDday
    }
    
    func setTripDday(_ tripDday: Int) {
        self.tripDday = tripDday
    }
    
    func getTripImage() -> String {
        return self.tripImage
    }
    
    func setTripImage(_ tripImage : String){
        self.tripImage = tripImage
    }

}
