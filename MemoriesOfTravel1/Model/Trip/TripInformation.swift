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
    
    // 저장된 정보 불러와서 표시할 때
    var tripInfo: TripInfo?

    func setTripInfo(_ info: TripInfo){
        self.tripInfo = info
    }
    
    func getTripInfo() -> TripInfo? {
        guard let tripInfo = self.tripInfo else { return nil }
        
        return tripInfo
    }
    
    func getTripPK() -> Int {
        guard let tripPK = self.tripInfo?.getTripPK() else { return 0 }
        
        return tripPK
    }
    
    func getTripName() -> String {
        guard let tripName = self.tripInfo?.getTripName() else { return "" }
        
        return tripName
    }
    
    func getTripFirstDay() -> String {
        guard let tripFirstDay = self.tripInfo?.getTripFirstDay() else { return "" }
        
        return tripFirstDay
    }
    
    func getTripPeriod() -> String {
        guard let tripPeriod = self.tripInfo?.getTripPeriod() else { return "" }
        
        return tripPeriod
    }
    
    func getTripDate() -> String {
        guard let tripDate = self.tripInfo?.getTripDate() else { return "" }
        
        return tripDate
    }
    
    //MARK: - 새로운 여행지 등록
    var newTrip = TripModel()
    
    func loadTripName() -> String? {
        return newTrip.getTripName()
    }
    
    func registerTripName(_ tripName: String){
        newTrip.setTripName(tripName)
    }
    
    func loadTripFirstDay() -> String? {
        return newTrip.getTripFirstDay()
    }
    
    func registerTripFirstDay(_ tripFirstDay: String){
        newTrip.setTripFirstDay(tripFirstDay)
    }
    
    func loadTripPeriod() -> String? {
        return newTrip.getTripPeriod()
    }
    
    func registerTripPeriod(_ tripPeriod: String){
        newTrip.setTripPeriod(tripPeriod)
    }
    
    func loadTripDate() -> String? {
        return newTrip.getTripDate()
    }
    
    func registerTripDate(_ tripDate: String){
        newTrip.setTripDate(tripDate)
    }
    
    //MARK: - 모든 여행 리스트
    var allTripList = [String]()
    
    func getAllTripList() -> [String] {
        return allTripList
    }
    
    func setAllTripList(_ tripList: [String]){
        self.allTripList = tripList
    }
    
    //MARK: - 모든 여행 리스트
    var allTripInfo = [TripInfo]()
    
    func getAllTripInfo() -> [TripInfo] {
        return allTripInfo
    }
    
    func setAllTripInfo(_ tripInfo: [TripInfo]){
        self.allTripInfo = tripInfo
    }
    
    
}
