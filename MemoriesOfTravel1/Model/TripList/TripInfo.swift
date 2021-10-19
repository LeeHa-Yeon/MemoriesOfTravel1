//
//  TripInfo.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/18.
//

import UIKit

struct TripInfo: Codable {
    var tripPK: Int
    var tripName: String
    var tripFirstDay: String
    var tripPeriod: String
    var tripDate: String

    var toDictionary: [String: Any] {
        let dict: [String:Any] = ["tripPK":self.tripPK,
                                     "tripName": self.tripName,
                                     "tripFirstDay":self.tripFirstDay,
                                     "tripPeriod":self.tripPeriod,
                                     "tripDate":self.tripDate]
        return dict
    }
    
    func getTripPK() -> Int {
        return self.tripPK
    }
    
    func getTripName() -> String {
        return self.tripName
    }
    
    func getTripFirstDay() -> String {
        return self.tripFirstDay
    }
    
    func getTripPeriod() -> String {
        return self.tripPeriod
    }
    
    func getTripDate() -> String {
        return self.tripDate
    }
    
}
