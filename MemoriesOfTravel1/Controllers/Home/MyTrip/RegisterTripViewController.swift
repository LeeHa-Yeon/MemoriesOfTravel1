//
//  RegisterTripViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import Firebase
import FirebaseStorage

class RegisterTripViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    let tripInformation: TripInformation = TripInformation.shared
    let firebaseManager = FirebaseManager.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let loadingTripName = NSAttributedString(string: tripInformation.loadTripName() ?? "")
        let loadingTripDate = NSAttributedString(string: tripInformation.loadTripDate() ?? "")
        self.tripName.setAttributedTitle(loadingTripName, for: .normal)
        self.tripDate.setAttributedTitle(loadingTripDate, for: .normal)
    }
    
    @IBOutlet weak var tripName: UIButton! {
        didSet{
            tripName.layer.borderWidth = 1.5
            tripName.layer.borderColor = #colorLiteral(red: 0.4392628074, green: 0.4358027577, blue: 0.4419106245, alpha: 1)
            tripName.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
            tripName.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var tripDate: UIButton! {
        didSet {
            tripDate.layer.borderWidth = 1.5
            tripDate.layer.borderColor = #colorLiteral(red: 0.5670574307, green: 0.5625883341, blue: 0.5704758763, alpha: 1)
            tripDate.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
            tripDate.layer.cornerRadius = 10
        }
    }
    
    @IBAction func cancleButton(_ sender: UIButton){
        tripInformation.registerTripName("")
        tripInformation.registerTripDate("")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveAddTrip(_ sender: UIButton){
        myInformation.updateTripCnt()
        firebaseManager.updateTripCnt(uid: myInformation.getUid(),tripCnt: myInformation.getTripCnt())
        firebaseManager.saveTripInfo(uid: myInformation.getUid(), tripName: tripInformation.loadTripName()!, tripPK: 1, tripFD: tripInformation.loadTripFirstDay()!, tripPeriod: tripInformation.loadTripPeriod()!, tripDate: tripInformation.loadTripDate()!)
        tripInformation.registerTripName(" ")
        tripInformation.registerTripDate(" ")
        firebaseManager.loadTripList(uid: myInformation.getUid()) { response in
            guard let response = response else {
                print("여행 등록 후 로드 과정에서 문제 생김")
                return
            }
            self.tripInformation.setAllTripList(response)
            var allTripInfo = [TripInfo]()
            var cnt:Int = 1
            for value in response {
                self.firebaseManager.loadTripInfo(uid: self.myInformation.getUid(), tripName: value) { response2 in
                    
                    guard let response2 = response2 else {
                        print("여행 정보 없음")
                        return
                    }
                    allTripInfo.append(response2)
                    if cnt == response.count {
                        self.tripInformation.setAllTripInfo(allTripInfo)
                        self.dismiss(animated: true, completion: nil)
                    }
                    cnt+=1
                }
            }
        }
 
    }
    
    
    // 현재 사용 안함 -> 옛날에 파일명쓸때 사용했었음
    // 파이어베이스의 child는 -,:와 같은 특수문자가 못들어가서 이와 같이 바꿔서 넣어주자
    //    fileprivate let formatter: DateFormatter = {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyyMMdd"
    //        return formatter
    //    }()
    
}

extension Date { static func - (lhs: Date, rhs: Date) -> TimeInterval { return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate } }
