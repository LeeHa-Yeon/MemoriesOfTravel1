//
//  TripInformation.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import Foundation
import UIKit

class TripInformation{
    
    static let shared: TripInformation = TripInformation()
    
    private init(){}
    
    var newTripInfo: Trip = Trip()
    
    func getTripName() -> String {
        return newTripInfo.getTripName()
    }

    func setTripName(tripName: String){
        newTripInfo.setTripName(tripName)
    }
    
    func getTripPK() -> String {
        return newTripInfo.getTripPK()
    }
    
    func setTripPK(tripPK: String){
        newTripInfo.setTripPK(tripPK)
    }
    
    func getTripFirstDay() -> Date {
        return newTripInfo.getTripFirstDay()
    }
    
    func setTripFirstDay(tripFirstDay: Date){
        newTripInfo.setTripFirstDay(tripFirstDay)
    }
    
    func getTripDate() -> String {
        return newTripInfo.getTripDate()
    }
    
    func setTripDate(tripDate: String){
        newTripInfo.setTripDate(tripDate)
    }
    
    func getTripRange() -> Int {
        return newTripInfo.getTripRange()
    }
    
    func setTripRange(tripRange: Int){
        newTripInfo.setTripRange(tripRange)
    }
    
    func getTripDday() -> Int {
        return newTripInfo.getTripDday()
    }
    
    func setTripDday(tripDday: Int){
        newTripInfo.setTripDday(tripDday)
    }
    
    func getTripImage() -> String {
        return newTripInfo.getTripImage()
    }
    
    func setTripImage(tripImage: String){
        newTripInfo.setTripImage(tripImage)
    }

    
    var myAllTrip: TripList = TripList(myTripList: ["":[:]])
    
    func getMyTripList() -> [String:[String:Any]] {
        return myAllTrip.getMyTripList()
    }
    
    func setMyTripList(tripList: [String:[String:Any]]){
        myAllTrip.setMyTripList(tripList)
    }
    
    func createTripSheet(_ tripPK: String, _ tripName: String,_ tripFirstDay: String, _ tripDate: String,_ tripRange: Int, _ tripDday: Int, _ tripImage: String) -> [String:Any] {
        var newSheet = [String:Any]()
//        print("나는 프라이머리키야 ^^ -->",tripPK)
        newSheet["여행지"] = tripName
        newSheet["여행첫날"] = tripFirstDay
        newSheet["날짜"] = tripDate
        newSheet["여행기간"] = tripRange
        newSheet["디데이"] = tripDday
        newSheet["여행사진"] = tripImage
//        print("나는 새로운 시트야 -->",newSheet)
        return newSheet
    }
    
    func addTripInfo(_ tripPK: String, _ sheetInfo: [String:Any]){
//        print("입주하기전 -->",myAllTrip)
        var updateTripList = myAllTrip.getMyTripList()
        updateTripList[tripPK] = sheetInfo
        myAllTrip.setMyTripList(updateTripList)
//        print("입주한 후 -->",myAllTrip)
    }


}
