//
//  Trip.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

struct TripList {
    // [여행PK:[여행지: String, 날짜: String ,여행기간: String, 디데이: Int, 여행사진: Stirng, 여행첫날: String]]
    private var myTripList: [String:[String:Any]]

    
    init(myTripList: [String:[String:Any]]){
        self.myTripList = myTripList
    }

    func getMyTripList() -> [String:[String:Any]] {
        return self.myTripList
    }
    
    mutating func setMyTripList(_ myTripList: [String:[String:Any]]){
        self.myTripList = myTripList
    }

}
