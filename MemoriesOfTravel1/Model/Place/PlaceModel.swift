//
//  PlaceModel.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/19.
//

import Foundation

class PlaceModel{
    private var tripDate: String
    private var placeName: String
    private var x: String
    private var y: String
    private var category: String
    
    init(){
        self.tripDate = ""
        self.placeName = ""
        self.x = ""
        self.y = ""
        self.category = ""
    }
    
    func getTripDate() -> String {
        return self.tripDate
    }
    
    func setTripDate(_ tripDate: String){
        self.tripDate = tripDate
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
