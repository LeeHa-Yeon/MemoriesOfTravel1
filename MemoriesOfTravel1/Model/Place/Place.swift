//
//  Place.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/15.
//

import Foundation

class Place{
    private var placeName: String
    private var x: String
    private var y: String
    private var category: String
    private var distance: Double
    private var time: String
    private var memo: String
    private var cost: Int
    
    init(){
        self.placeName = ""
        self.x = ""
        self.y = ""
        self.category = ""
        self.distance = 0
        self.time = ""
        self.memo = ""
        self.cost = 0
    }
    
    func getPlaceName() -> String {
        return self.placeName
    }
    
    func setPlaceName(_ placeName: String){
        self.placeName = placeName
    }
    
    func getX() -> String {
        return self.x
    }
    
    func setX(_ x: String){
        self.x = x
    }
    
    func getY() -> String {
        return self.y
    }
    
    func setY(_ y: String){
        self.y = y
    }
    
    func getCategory() -> String {
        return self.category
    }
    
    func setCategory(_ category: String){
        self.category = category
    }
    
}
