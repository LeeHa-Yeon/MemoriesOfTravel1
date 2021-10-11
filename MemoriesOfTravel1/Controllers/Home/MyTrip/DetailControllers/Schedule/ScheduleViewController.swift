//
//  ScheduleViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let selectTripInfo : TripInformation = TripInformation.shared
    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let dayRange = selectTripInfo.getTripRange()
        navigationItem.title = "\(dayRange-1)박 \(dayRange)일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        if sender.selectedSegmentIndex == 0 {
            dayView.alpha = 1
            mapView.alpha = 0
            
            if let DayVC = storyboard.instantiateViewController(identifier: "DaySB") as? DayViewController {
                addChild(DayVC)
                dayView.addSubview(DayVC.view)
                DayVC.didMove(toParent: self)
            }
        }else{
            dayView.alpha = 0
            mapView.alpha = 1
            if let MapVC = storyboard.instantiateViewController(identifier: "MapSB") as? MapViewController {
                addChild(MapVC)
                mapView.addSubview(MapVC.view)
                MapVC.didMove(toParent: self)
            }
        }
    }
}
