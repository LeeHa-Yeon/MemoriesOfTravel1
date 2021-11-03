//
//  ScheduleViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import EASegments

class ScheduleViewController: UIViewController,EASegmentsDelegate {
    
    @IBOutlet weak var segmentsViaIB: EASegments!
    let carmine =  #colorLiteral(red: 0.2004446089, green: 0.2323476076, blue: 0.4184677899, alpha: 1)
    let flamingo = #colorLiteral(red: 0.495657444, green: 0.7202214599, blue: 0.9071255922, alpha: 1)
    
    let selectTripInfo : TripInformation = TripInformation.shared
    let myInformation: UserInfomation = UserInfomation.shared
    let placeInfo: PlaceInformation = PlaceInformation.shared
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var map2View: UIView!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegment()
    }
    
    func setupSegment(){
        segmentsViaIB.titles = ["Day", "Map"]
        
        segmentsViaIB.backgroundColor = flamingo
        segmentsViaIB.selectedBackgroundColor = .white
        
        segmentsViaIB.titleColor = carmine
        segmentsViaIB.selectedTitleColor = carmine
        
        segmentsViaIB.titleFont = UIFont(name: "HelveticaNeue-Light", size: 13.0)
        segmentsViaIB.delegate = self
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
    
    // addTarget
    @objc
    @IBAction func segmentsValueDidChange(_ sender: EASegments) {
        print("valueChanged: \(sender.selectedIndex) [\(sender.selectedTitle ?? "nil")]")
    }
    
    // EASegmentsDelegate
    func segments(_ segments: EASegments, didSelectAt index: Int) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        if segments.selectedIndex == 0 {
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
        print("didSelectAt: \(segments.selectedIndex) [\(segments.selectedTitle ?? "nil")]")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
