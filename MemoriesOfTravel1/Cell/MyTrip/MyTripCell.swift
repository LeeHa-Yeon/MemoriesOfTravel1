//
//  MyTripCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import Firebase

class MyTripCell: UICollectionViewCell {
    let myInformation: UserInfomation = UserInfomation.shared
    let selectTripInformation: TripInformation = TripInformation.shared
    
    var delegate: MyTripCellDelegate?
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripDdayLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var tripImage: UIButton!
    
    var tripPK: String = ""

    
    @IBAction func moveDetailView(_ sender: UIButton){
        loadingData{ response in
            self.loadingUserFB(tripInfoDict: response)
            self.delegate?.moveToDetailVC()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    // 선택한 여행 정보 모두 가져오기
    var ref = Database.database().reference()
    func loadingData(completion: @escaping (([String:Any])->(Void))){
        self.ref.child("user").child("\(myInformation.getPrimaryKey())").child("myTripList").child(tripPK).observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value
            let dic = values as! [String:Any]
            completion(dic)
        })
    }
    func loadingUserFB(tripInfoDict: [String: Any]){
        let date: Date = formatter.date(from:tripInfoDict["여행첫날"] as! String) ?? Date()
        selectTripInformation.setTripPK(tripPK: tripPK)
        selectTripInformation.setTripName(tripName: tripInfoDict["여행지"] as! String)
        // 여행 첫날은 String을 Date형으로 다시 바꿔서 넣어줘야됨
        selectTripInformation.setTripFirstDay(tripFirstDay: date)
        selectTripInformation.setTripDate(tripDate: tripInfoDict["날짜"] as! String)
        selectTripInformation.setTripRange(tripRange: tripInfoDict["여행기간"] as! Int)
        selectTripInformation.setTripDday(tripDday: tripInfoDict["디데이"] as! Int)
        selectTripInformation.setTripImage(tripImage: tripInfoDict["여행사진"] as! String)
        
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter
    }()

}

