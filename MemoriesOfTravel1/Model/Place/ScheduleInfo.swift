//
//  ScheduleInfo.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/30.
//

import UIKit

struct ScheduleInfo{
    var key: String
    var value: [String:Any]
    
    init(key: String, value: [String:Any]){
        self.key = key
        self.value = value
    }
}
