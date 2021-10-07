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
    
    var userInfo: User = User(id: "", password: "", name: "", profile: nil)
    
    func registUserId(id: String){
        userInfo.setId(id)
    }
    
    func registUserPwd(password: String){
        userInfo.setPassword(password)
    }
    
    func registUserProfile(profile: UIImage?){
        userInfo.setProfile(profile)
    }
    
    func registUserName(name: String){
        userInfo.setName(name)
    }

//    func registUserBirth(birth: String){
//        userInfo.setBirth(birth)
//    }
    
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
    
    
}
