//
//  ResultViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/15.
//

import UIKit
import Firebase

class ResultViewController: UIViewController {
    
    let myInfo: UserInfomation = UserInfomation.shared
    let tripInfo : TripInformation = TripInformation.shared
    let newPlace = PlaceInformation.shared
    let firebaseManager = FirebaseManager.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager.savePlaceInfo(uid: myInfo.getUid(), order: 1, tripName: (tripInfo.getTripInfo()?.getTripName())!, placeName: newPlace.loadPlaceName(), x: newPlace.loadX(), y: newPlace.loadY(), category: newPlace.loadCategory())
        firebaseManager.savePlace(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, tripDate: newPlace.getTripDate()!, schedule: newPlace.getScheduleList())
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
          // 1초 후 실행될 부분
            self.dismiss(animated: true, completion: nil)
//            guard let pvc = self.presentingViewController else { return }
//            self.dismiss(animated: true) {
//              pvc.present(DayViewController(), animated: true, completion: nil)
//            }
        }
    }

}
