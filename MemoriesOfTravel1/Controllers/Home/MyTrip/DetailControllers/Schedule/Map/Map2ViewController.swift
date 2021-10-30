//
//  Map2ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/16.
//

import UIKit
import DropDown
import NMapsMap

class Map2ViewController: UIViewController {
    // @@ 주석 @@
    // let placeInfo = PlaceInformation.shared
    
    let selectTripInfo: TripInformation = TripInformation.shared
    let dropDown = DropDown()
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var label: UILabel!
    var tripPeriod: Int = 0
    var mapView : NMFMapView {
            return naverMapView.mapView
        }
    
    
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBAction func clickDropDown(_ sender: UIButton){
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            label.text = "\(item)"
            self.dropDown.clearSelection()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tripPeriod = Int(selectTripInfo.getTripInfo()!.getTripPeriod()) ?? 0
        dropDown.dataSource = [String]()
        for i in 0..<tripPeriod {
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
