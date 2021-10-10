//
//  ScheduleViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dayView.alpha = 1
            mapView.alpha = 0
            let storyboard = UIStoryboard(name:"Main",bundle: nil)
            if let DayVC = storyboard.instantiateViewController(identifier: "DayViewController") as? DayViewController {
                addChild(DayVC)
                dayView.addSubview(DayVC.view)
                DayVC.didMove(toParent: self)
            }
        }else{
            dayView.alpha = 0
            mapView.alpha = 1
            let storyboard2 = UIStoryboard(name:"Main",bundle: nil)
            if let MayVC = storyboard2.instantiateViewController(identifier: "MapViewController") as? MapViewController {
                addChild(MayVC)
                mapView.addSubview(MayVC.view)
                MayVC.didMove(toParent: self)
            }
        }
    }
}
