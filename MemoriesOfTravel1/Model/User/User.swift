//
//  User.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

struct User {
    private var profile: UIImage?
    private var id: String
    private var password: String
    private var name: String
    private var tripCnt: Int
    private var primaryKey: String
    
    init(id: String, password: String, name: String, profile: UIImage?,tripCnt: Int,primaryKey: String){
        self.id = id
        self.password = password
        self.name = name
        //self.birth = birth
        self.profile = profile
        self.tripCnt = tripCnt
        self.primaryKey = primaryKey
    }
    
    func getPrimaryKey() -> String {
        return self.primaryKey
    }
    
    mutating func setPrimaryKey(_ primaryKey: String){
        self.primaryKey = primaryKey
    }
    
    func getId() -> String {
        return self.id
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getTripCnt() -> Int {
        return self.tripCnt
    }
    
    func getProfile() ->
    UIImage? {
        return self.profile
    }
    
    mutating func setId(_ id: String){
        self.id = id
    }
    
    mutating func setPassword(_ password: String){
        self.password = password
    }
    
    mutating func setName(_ name: String){
        self.name = name
    }
    
    mutating func setProfile(_ profile: UIImage?){
        self.profile = profile
    }
    
    mutating func setTripCnt(_ tripCnt: Int){
        self.tripCnt = tripCnt
    }
    
}
