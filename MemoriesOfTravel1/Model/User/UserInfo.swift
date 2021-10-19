//
//  UserInfo.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/17.
//

import UIKit

struct UserInfo: Codable {
    var uid: String
    var id: String
    var password: String
    var name: String
    var tripCnt: String
    
    
    var toDictionary: [String: String] {
        let dict: [String:String] = ["uid":self.uid,
                                     "id": self.id,
                                     "password":self.password,
                                     "name":self.name,
                                     "tripCnt":self.tripCnt]
        return dict
    }
    
    mutating func updateTripCnt(){
        self.tripCnt = "\(Int(self.tripCnt)!+1)"
//        self.tripCnt = "\(Int(self.tripCnt) ?? 0 + 1)"
    }
    
    func getUid() -> String {
        return self.uid
    }
    func getId() -> String {
        return self.id
    }
    func getName() -> String {
        return self.name
    }
    func getTripCnt() -> String {
        return self.tripCnt
    }
}
