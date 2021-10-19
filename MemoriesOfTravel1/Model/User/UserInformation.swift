//
//  UserInformation.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import Foundation
import UIKit

class UserInfomation{
    static let shared: UserInfomation = UserInfomation()
    
    private init(){}
    
    
    var userInfo: UserInfo?

    func setUserInfo(_ info: UserInfo){
        self.userInfo = info
    }
    
    func getUserInfo() -> UserInfo? {
        guard let userInfo = self.userInfo else { return nil }
        
        return userInfo
    }
    
    func updateTripCnt(){
        self.userInfo?.updateTripCnt()
    }
    
    func getUid() -> String {
        guard let uid = self.userInfo?.getUid() else { return "" }
        
        return uid
    }
    func getId() -> String {
        guard let id = self.userInfo?.getId() else { return "" }
        
        return id
    }
    func getName() -> String {
        guard let name = self.userInfo?.getName() else { return "" }

        return name
    }
    func getTripCnt() -> String {
        guard let tripCnt = self.userInfo?.getTripCnt() else { return "" }
        
        return tripCnt
    }
}
