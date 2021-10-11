//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit
import Firebase

class ViewController: UITabBarController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    let myTripInformation: TripInformation = TripInformation.shared
    var myTripDict = [String: [String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        loadingData{ response in
            self.myTripDict = response
            self.myTripInformation.setMyTripList(tripList: self.myTripDict)
            //print("나는 뷰 컨트롤러",self.myTripInformation.getMyTripList())
        }
    }
    
    // 나의 여행 리스트 모두 가져오기
    var ref = Database.database().reference()
    func loadingData(completion: @escaping (([String: [String:Any]])->(Void))){
        self.ref.child("user").child("\(myInformation.getPrimaryKey())").child("myTripList").observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value
            let dic = values as! [String: [String:Any]]
            completion(dic)
        })
    }
    
    
}
