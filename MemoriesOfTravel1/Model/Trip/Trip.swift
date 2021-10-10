//
//  Trip.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

struct Trip {
    private var image: UIImage?
    private var name: String
    private var date: String
    private var D_day: Int
    private var originDate: Date
    private var dateRange: Int
    private var myTripList: [String:[String:Any]]

    
    init(name: String, date: String, D_day: Int, image: UIImage?,originDate: Date,dateRange: Int,myTripList: [String:[String:Any]]){
        self.image = image
        self.name = name
        self.date = date
        self.D_day = D_day
        self.originDate = originDate
        self.dateRange = dateRange
        self.myTripList = myTripList
    }
    
    mutating func setMyTripList(_ myTripList: [String:[String:Any]]){
        self.myTripList = myTripList
    }
    
    func getMyTripList() -> [String:[String:Any]] {
        return self.myTripList
    }

    func getDateRange() -> Int {
        return self.dateRange
    }
    
    func getOriginDate() -> Date {
        return self.originDate
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getDate() -> String {
        return self.date
    }
    
    func getDday() -> Int {
        return self.D_day
    }

    func getImage() ->
    UIImage? {
        return self.image
    }
    
    mutating func setDateRange(_ dateRange: Int){
        self.dateRange = dateRange
    }
    
    
    mutating func setName(_ name: String){
        self.name = name
    }
    mutating func setDday(_ Dday: Int){
        self.D_day = Dday
    }
    mutating func setImage(_ image: UIImage?){
        self.image = image
    }
    mutating func setDate(_ date: String){
        self.date = date
    }
    
    mutating func setOriginDate(_ originDate: Date){
        self.originDate = originDate
    }
    
}
