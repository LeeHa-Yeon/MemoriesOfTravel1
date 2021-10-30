//
//  PlaceInformation.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/19.
//

import Foundation

class PlaceInformation{
    
    static let shared: PlaceInformation = PlaceInformation()
    
    private init(){}
    
    var scheduleInfoList = [ScheduleInfo]()
    
    // 저장된 정보 불러와서 표시할 때
    var placeInfo: PlaceInfo?
    
    func setPlaceInfo(_ info: PlaceInfo){
        self.placeInfo = info
    }
    
    func getPlaceInfo() -> PlaceInfo? {
        guard let placeInfo = self.placeInfo else { return nil }
        
        return placeInfo
    }

    //MARK: - 새로운 여행지 등록
    var newPlace = PlaceModel()
    
    func getTripDate() -> String? {
        return newPlace.getTripDate()
    }
    
    func setTripDate(_ tripDate: String){
        newPlace.setTripDate(tripDate)
    }
    
    func loadPlaceName() -> String {
        return newPlace.getPlaceName()
    }
    func registerPlaceName(_ placeName: String){
        newPlace.setPlaceName(placeName)
    }
    func loadX() -> String {
        return newPlace.getX()
    }
    func registerX(_ x: String){
        newPlace.setX(x)
    }
    func loadY() -> String {
        return newPlace.getY()
    }
    func registerY(_ y: String){
        newPlace.setY(y)
    }
    func loadCategory() -> String {
        return newPlace.getCategory()
    }
    func registerCategory(_ category: String){
        newPlace.setCategory(category)
    }
    
    //MARK: -- 모든 일정 관리
    var scheduleList = [String]()
    
    func getScheduleList() -> [String] {
        return scheduleList
    }
    
    func setScheduleList(_ tripList: [String]){
        self.scheduleList = tripList
    }
    
    //MARK: -- 모든 메모 관리
    var memoList = [String]()
    
    func getMemoList() -> [String] {
        return memoList
    }
    
    func setMemoList(_ memoList: [String]){
        self.memoList = memoList
    }


}
