//
//  Map2ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/16.
//

import UIKit
import DropDown

class Map2ViewController: UIViewController {
    let selectTripInfo: TripInformation = TripInformation.shared
    let dropDown = DropDown()
    
    
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBAction func clickDropDown(_ sender: UIButton){
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            self.dropDown.clearSelection()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.dataSource = [String]()
        for i in 0..<selectTripInfo.getTripRange() {
            dropDown.dataSource.append("Day \(i+1)")
        }
        dropDown.anchorView = dropDownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
    }

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()

}
