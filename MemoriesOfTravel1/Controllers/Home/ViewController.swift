//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

class ViewController: UITabBarController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    let firebaseManager = FirebaseManager.shared
    let myTripList = TripInformation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.selectedIndex = 1
//        selectedTabIndex = 1
        // 처음 사용자의 여행 리스트 정보를 불러온다.
        firebaseManager.loadTripList(uid: myInformation.getUid()) { response in
            
            guard let response = response else {
                print("아직 여행 리스트 없음")
                return
            }
            self.myTripList.setAllTripList(response)
            var allTripInfo = [TripInfo]()
            for value in response {
                self.firebaseManager.loadTripInfo(uid: self.myInformation.getUid(), tripName: value) { response2 in
                    
                    guard let response2 = response2 else {
                        print("여행 정보 없음")
                        return
                    }
                    allTripInfo.append(response2)
                    self.myTripList.setAllTripInfo(allTripInfo)
                }
            }
        }
    }
    
}
