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
    var newTripDict = [String:Any]()
    var key: String = ""
   
    @IBOutlet weak var tripName: UIButton!
    @IBOutlet weak var tripDate: UIButton!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func moveAddTrip(_ sender: UIButton){
        let day = Int(registerTripInfo.getOriginDate()-Date())/(24*60*60) + 1
        
        key = myInformation.getPrimaryKey()
        let fileName = formatter.string(from: registerTripInfo.getOriginDate())+registerTripInfo.getTripName()

        newTripDict["여행지"] = registerTripInfo.getTripName()
        newTripDict["날짜"] = registerTripInfo.getTripDate()
        newTripDict["디데이"] = day
        newTripDict["여행사진"] = registerTripInfo.getTripName()
        newTripDict["여행첫날"] = formatter2.string(from: registerTripInfo.getOriginDate())
        newTripDict["여행기간"] = registerTripInfo.getDateRange()

        
        self.ref = Database.database().reference()
        let newTrip = self.ref.child("user").child(key).child("myTripList").child(fileName)
        newTrip.setValue(newTripDict)
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tripName.layer.borderWidth = 1.5
        tripName.layer.borderColor = #colorLiteral(red: 0.4392628074, green: 0.4358027577, blue: 0.4419106245, alpha: 1)
        tripName.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        tripName.layer.cornerRadius = 10
        
        tripDate.layer.borderWidth = 1.5
        tripDate.layer.borderColor = #colorLiteral(red: 0.5670574307, green: 0.5625883341, blue: 0.5704758763, alpha: 1)
        tripDate.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        tripDate.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let loadingTripName = NSAttributedString(string: registerTripInfo.getTripName())
        let loadingTripDate = NSAttributedString(string: registerTripInfo.getTripDate())
        self.tripName.setAttributedTitle(loadingTripName, for: .normal)
        self.tripDate.setAttributedTitle(loadingTripDate, for: .normal)
    }

    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter2
    }()
    
}

extension Date { static func - (lhs: Date, rhs: Date) -> TimeInterval { return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate } }
