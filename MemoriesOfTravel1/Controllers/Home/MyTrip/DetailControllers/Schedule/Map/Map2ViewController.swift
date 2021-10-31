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
    
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var label: UILabel!
    let selectTripInfo: TripInformation = TripInformation.shared
    let placeInfo : PlaceInformation = PlaceInformation.shared
    let myInfo : UserInfomation = UserInfomation.shared
    let firebaseManager : FirebaseManager = FirebaseManager.shared
    let dropDown = DropDown()
    var tripPeriod: Int = 0
    var tripFirstDay = Date()
    var selectDate = ""
    public var DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat: 35.15978615475503, lng: 129.16109290865137), zoom: 10, tilt: 0, heading: 0)
    var mapView : NMFMapView {
            return naverMapView.mapView
        }
    
    
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBAction func clickDropDown(_ sender: UIButton){
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectDate = formatter.string(from: tripFirstDay+TimeInterval(86400*(index)))
            firebaseManager.loadSchedule(uid: myInfo.getUid(), tripName: selectTripInfo.getTripInfo()!.getTripName(), tripDate: selectDate) { response in
                var coords1 = [NMGLatLng]()
                coords1.removeAll()
                var polylineOverlay: NMFPolylineOverlay
//                polylineOverlay.mapView = nil
                for placeName in response! {
                    if placeName != "일정을 추가해주세요" {
                        for i in placeInfo.scheduleInfoList {
                            if i.key == placeName {
                                let lng = i.value["x"] as! String
                                let lat = i.value["y"] as! String
                                coords1.append(NMGLatLng(lat: Double(lat)!, lng: Double(lng)!))
                            }
                        }
                    }
                } // for end
                DEFAULT_CAMERA_POSITION = NMFCameraPosition(coords1[0], zoom: 14, tilt: 0, heading: 0)
                mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
                let lineString = NMGLineString(points: coords1)
                polylineOverlay = NMFPolylineOverlay(lineString as! NMGLineString<AnyObject>)!
                polylineOverlay.width = 3
                polylineOverlay.pattern = [6, 3]
                polylineOverlay.color = UIColor.gray
                polylineOverlay.mapView = mapView
                print("coords1--->\(coords1)")
                self.dropDown.clearSelection()
            } // fire end
            
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
        tripFirstDay = formatter2.date(from: selectTripInfo.getTripInfo()!.getTripFirstDay())!
        // 초기화해줌 나중에 지워도됨
        label.text = ""
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
    }

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월_dd일"
        return formatter
    }()

    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter2.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter2
    }()
}
