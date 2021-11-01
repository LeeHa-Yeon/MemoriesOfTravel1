//
//  CheckListManager.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import Foundation

class CheckListManager{
    
    static let shared: CheckListManager = CheckListManager()
    
    private init(){}
    
    //MARK: -- 모든 체크 관리
    var checkList = [String]()
    
    func getCheckList() -> [String] {
        return checkList
    }
    
    func setCheckList(_ checkList: [String]){
        self.checkList = checkList
    }
    
    //MARK: -- 모든 언체크 관리
    var unCheckList = [String]()
    
    func getUnCheckList() -> [String] {
        return unCheckList
    }
    
    func setUnCheckList(_ unCheckList: [String]){
        self.unCheckList = unCheckList
    }
    
}
