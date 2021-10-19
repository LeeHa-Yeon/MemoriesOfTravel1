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
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var cateLable: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseManager.savePlaceInfo(uid: myInfo.getUid(), order: 1, tripName: (tripInfo.getTripInfo()?.getTripName())!, placeName: newPlace.loadPlaceName(), x: newPlace.loadX(), y: newPlace.loadY(), category: newPlace.loadCategory())
        firebaseManager.savePlace(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, tripDate: newPlace.getTripDate()!, schedule: newPlace.getScheduleList())
        
        
        xLabel.text = newPlace.loadX()
        yLabel.text = newPlace.loadY()
        cateLable.text = newPlace.loadCategory()
        placeLabel.text = newPlace.loadPlaceName()
    
    }

}
