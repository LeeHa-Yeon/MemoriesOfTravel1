//
//  TripInformation.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import Foundation
import UIKit

class TripInformation{
    static let shared: TripInformation = TripInformation()
    
    private init(){}
    
    var userTrip: Trip = Trip(name: "", date: "", D_day: 0, image: nil)
    
    func setTripName(name: String){
        userTrip.setName(name)
    }
    
    func setTripDate(date: String){
        userTrip.setDate(date)
    }
    
    func setTripImage(image: UIImage?){
        userTrip.setImage(image)
    }
    
    func setTripDday(d_day: Int){
        userTrip.setDday(d_day)
    }
    

    func getTripName() -> String {
        return userTrip.getName()
    }
    
    func getTripDate() -> String {
        return userTrip.getDate()
    }

    func getTripImage() -> UIImage {
        return userTrip.getImage()!
    }
    
    func getTripDday() -> Int {
        return userTrip.getDday()
    }
    
    
}
