//
//  Calculate.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import Foundation

class CalculateManager{
    
    static let shared: CalculateManager = CalculateManager()
    
    private init(){}
    
    //MARK: -- 모든 체크 관리
    var calculateList = [[String:Any]]()
    
    func getCalculateList() -> [[String:Any]] {
        return calculateList
    }
    
    func setCalculateList(_ calculateList: [[String:Any]]){
        self.calculateList = calculateList
    }
    
    var expectedCost = String()
    
    func getExpectedCost() -> String {
        return expectedCost
    }
    
    func setExpectedCost(_ expectedCost: String){
        self.expectedCost = expectedCost
    }

    
}
