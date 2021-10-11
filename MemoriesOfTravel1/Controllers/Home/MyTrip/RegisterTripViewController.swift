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
    let registerTripInfo: TripInformation = TripInformation.shared
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let loadingTripName = NSAttributedString(string: registerTripInfo.getTripName())
        let loadingTripDate = NSAttributedString(string: registerTripInfo.getTripDate())
        self.tripName.setAttributedTitle(loadingTripName, for: .normal)
        self.tripDate.setAttributedTitle(loadingTripDate, for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let loadingTripName = NSAttributedString(string: "")
        let loadingTripDate = NSAttributedString(string: "")
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
        dismiss(animated: true, completion: nil)
    }
    
    var newTripDict = [String:Any]()
    var key: String = ""
    var fileName: String = ""
    
    @IBAction func moveAddTrip(_ sender: UIButton){
        addNewTripFB()
        updateTripList()
        self.dismiss(animated: true, completion: nil)
    }
    func addNewTripFB(){
        self.ref = Database.database().reference()
        key = myInformation.getPrimaryKey()
        fileName = formatter.string(from: registerTripInfo.getTripFirstDay())+registerTripInfo.getTripName()
        
        newTripDict["여행지"] = registerTripInfo.getTripName()
        newTripDict["여행사진"] = registerTripInfo.getTripImage()
        newTripDict["날짜"] = registerTripInfo.getTripDate()
        newTripDict["여행첫날"] = formatter2.string(from: registerTripInfo.getTripFirstDay())
        newTripDict["디데이"] = registerTripInfo.getTripDday()
        newTripDict["여행기간"] = registerTripInfo.getTripRange()
        
        let newTrip = self.ref.child("user").child(key).child("myTripList").child(fileName)
        newTrip.setValue(newTripDict)
    }
    
    func updateTripList(){
        let newTrip = registerTripInfo.createTripSheet(myInformation.getPrimaryKey(), registerTripInfo.getTripName(), formatter2.string(from: registerTripInfo.getTripFirstDay()), registerTripInfo.getTripDate(), registerTripInfo.getTripRange(), registerTripInfo.getTripDday(), registerTripInfo.getTripImage())
        registerTripInfo.addTripInfo(fileName, newTrip)
    }

    // 파이어베이스의 child는 -,:와 같은 특수문자가 못들어가서 이와 같이 바꿔서 넣어주자
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    // 파이어베이스는 Date형식이 불가능하여 String형식으로 바꿔서 넣어줘야됨
    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter2
    }()
    
}

extension Date { static func - (lhs: Date, rhs: Date) -> TimeInterval { return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate } }
