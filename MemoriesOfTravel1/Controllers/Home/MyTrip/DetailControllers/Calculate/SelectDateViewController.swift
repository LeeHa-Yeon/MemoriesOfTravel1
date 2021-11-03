//
//  SelectDateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    let tripInfo = TripInformation.shared
    
    var firstDate:Date = Date()
    var lastDate:Date = Date()
    var tripRange:Int = 0
    
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func selectDatePicker(_ sender : UIDatePicker){
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        selectDateStr = formatter.string(from: datePickerView.date)
        selectDateLabel.text = "선택날짜 : " + formatter.string(from: datePickerView.date)
    }
    @IBAction func selectButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripRange = Int(tripInfo.getTripInfo()?.getTripPeriod() ?? "1")! - 1
        firstDate = formatter.date(from: (tripInfo.getTripInfo()?.getTripFirstDay())!) ?? Date()
        lastDate = firstDate+TimeInterval(86400*tripRange)
        
        datePicker.minimumDate = firstDate
        datePicker.maximumDate = lastDate
        datePicker.date = firstDate
        
        selectDateLabel.text = "여행날짜만 선택이 가능합니다."
        
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter
    }()
    
}
