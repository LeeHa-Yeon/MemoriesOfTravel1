//
//  ScheduleViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let selectTripInfo : TripInformation = TripInformation.shared
    let myInformation: UserInfomation = UserInfomation.shared
    let placeInfo: PlaceInformation = PlaceInformation.shared
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var map2View: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dayView.alpha = 1
        map2View.alpha = 0
        let dayRange = Int(selectTripInfo.getTripInfo()!.getTripPeriod())
        navigationItem.title = "\(dayRange!-1)박 \(dayRange!)일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
        
        firebaseManager.loadPlaceInfo(uid: myInformation.getUid(), tripName: selectTripInfo.getTripInfo()!.getTripName()) { response in
            for (key, value) in response{
                let item = ScheduleInfo(key: key, value: value)
                self.placeInfo.scheduleInfoList.append(item)
            }
        }
    }
    
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        if sender.selectedSegmentIndex == 0 {
            dayView.alpha = 1
            map2View.alpha = 0
            
            if let DayVC = storyboard.instantiateViewController(identifier: "DaySB") as? DayViewController {
                addChild(DayVC)
                dayView.addSubview(DayVC.view)
                DayVC.didMove(toParent: self)
            }
        }else{
            dayView.alpha = 0
            map2View.alpha = 1
            if let Map2VC = storyboard.instantiateViewController(identifier: "Map2SB") as? Map2ViewController {
                addChild(Map2VC)
                map2View.addSubview(Map2VC.view)
                Map2VC.didMove(toParent: self)
            }
        }
    }
}
