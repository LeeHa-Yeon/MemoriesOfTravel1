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
    //private var birth: String
    
    init(id: String, password: String, name: String, profile: UIImage?){
        self.id = id
        self.password = password
        self.name = name
        //self.birth = birth
        self.profile = profile
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
    
//    func getBirth() -> String {
//        return self.birth
//    }
    
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

//    mutating func setBirth(_ birth: String){
//        self.birth = birth
//    }
    
    mutating func setProfile(_ profile: UIImage?){
        self.profile = profile
    }
    
}
