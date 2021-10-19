//
//  TripInfo.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/18.
//

import UIKit

struct PlaceInfo: Codable {
    var placeName: String
    var order: Int
    var x: String
    var y: String
    var category: String
    var distance: Double
    var memo: String
    var cost: Int
    var time: String

    var toDictionary: [String: Any] {
        let dict: [String:Any] = ["placeName":self.placeName,
                                  "order":self.order,
                                     "x": self.x,
                                     "y":self.y,
                                     "category":self.category,
                                     "distance":self.distance,
                                     "memo": self.memo,
                                     "cost":self.cost,
                                     "time":self.time]
        return dict
    }
    
}
