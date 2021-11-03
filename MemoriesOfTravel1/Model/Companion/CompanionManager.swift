//
//  CompanionManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import Foundation

class CompanionManager{
    
    static let shared: CompanionManager = CompanionManager()
    
    private init(){}
    
    var companionList = [String]()
    
    func getCompanionList() -> [String] {
        return companionList
    }
    
    func setCompanionList(_ companionList: [String]){
        self.companionList = companionList
    }
    
}
