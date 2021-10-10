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
    
    var userInfo: User = User(id: "", password: "", name: "", profile: nil, tripCnt: 0, primaryKey:"")
    
    func setPrimaryKey(primaryKey:String){
        userInfo.setPrimaryKey(primaryKey)
    }
    func getPrimaryKey() -> String {
        return userInfo.getPrimaryKey()
    }
    
    func setUserId(id: String){
        userInfo.setId(id)
    }
    
    func setUserPwd(password: String){
        userInfo.setPassword(password)
    }
    
    func setUserProfile(profile: UIImage?){
        userInfo.setProfile(profile)
    }
    
    func setUserName(name: String){
        userInfo.setName(name)
    }
    
    func setUserTripCnt(tripCnt: Int){
        userInfo.setTripCnt(tripCnt)
    }

    func getUserId() -> String {
        return userInfo.getId()
    }
    
    func getUserPwd() -> String {
        return userInfo.getPassword()
    }
    
    func getUserName() -> String {
        return userInfo.getName()
    }
    
    func getUserProfile() -> UIImage {
        return userInfo.getProfile()!
    }
    
    func getUserTripCnt() -> Int {
        return userInfo.getTripCnt()
    }
    
    
}
