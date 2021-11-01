//
//  SelectDateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

class SelectDateViewController: UIViewController {
    @IBOutlet weak var selectDateLabel: UILabel!
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
    }
    
    
}
