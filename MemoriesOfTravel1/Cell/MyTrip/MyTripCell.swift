//
//  MyTripCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import Firebase

class MyTripCell: UICollectionViewCell {
    let userInfo: UserInfomation = UserInfomation.shared
    let selectTripInfo: TripInformation = TripInformation.shared
    let firebaseManager: FirebaseManager = FirebaseManager.shared
    
    var delegate: MyTripCellDelegate?
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripDdayLabel: UILabel!
    @IBOutlet weak var tripImage: UIButton!

    @IBAction func moveDetailView(_ sender: UIButton){
        let tripName = tripNameLabel.text ?? "오류"
        firebaseManager.loadTripInfo(uid: userInfo.getUid(), tripName: tripName) { response in
            guard let response = response else {
                print("여행 상세 정보 로딩 실패")
                return
            }
            self.selectTripInfo.setTripInfo(response)
            self.delegate?.moveToDetailVC()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}

