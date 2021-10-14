//
//  PlaceRequestParameter.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/14.
//

import UIKit

struct PlaceRequestParameter {
    private var query: String
    
    init(query: String){
        self.query = query
    }
    
    mutating func setQuery(query: String){
        self.query = query
    }

    var toDict: [String:Any]{
        let dict: [String:Any] = [
            "query" : self.query
            ]
        return dict
    }
    
}
