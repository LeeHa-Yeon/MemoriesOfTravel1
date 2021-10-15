//
//  PlaceInformation.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/15.
//

import Foundation
import UIKit

class PlaceInformation{
    
    static let shared: PlaceInformation = PlaceInformation()
    
    private init(){}
    
    var newPlaceInfo: Place = Place()
    
    func getPlaceName() -> String {
        return newPlaceInfo.getPlaceName()
    }

    func setPlaceName(placeName: String){
        newPlaceInfo.setPlaceName(placeName)
    }
    
    func getCategory() -> String {
        return newPlaceInfo.getCategory()
    }

    func setCategory(category: String){
        newPlaceInfo.setCategory(category)
    }
    
    func getX() -> String {
        return newPlaceInfo.getX()
    }

    func setX(x: String){
        newPlaceInfo.setX(x)
    }
    
    func getY() -> String {
        return newPlaceInfo.getY()
    }

    func setY(y: String){
        newPlaceInfo.setY(y)
    }
    
    
}
