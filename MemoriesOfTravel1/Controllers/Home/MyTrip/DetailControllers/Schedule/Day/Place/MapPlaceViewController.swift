//
//  MapPlaceViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/16.
//

import UIKit
import NMapsMap

class MapPlaceViewController: UIViewController {
    
    let newPlace = PlaceInformation.shared
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var crossHair: UIImageView!
    
    @IBAction func moveToCategory(_ sender: UIButton){
        newPlace.registerPlaceName(placeName.text!)
        guard let CategoryVC = self.storyboard?.instantiateViewController(identifier: "CategorySB") as? CategoryViewController else {
            return
        }
        navigationController?.pushViewController(CategoryVC, animated: true)

    }
    var mapView : NMFMapView {
        return naverMapView.mapView
    }
    
    public let DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat: 35.8347762643542, lng: 129.226975518857), zoom: 14, tilt: 0, heading: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(naverMapView)
        
        nextButton.layer.cornerRadius = 20
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        
        mapView.addCameraDelegate(delegate: self)
        self.naverMapView.bringSubviewToFront(self.crossHair)

    }
    func update() {
        print("asdasdasdsdas")
        let coord = mapView.projection.latlng(from: crossHair.center)
        print("확인",coord.lat,coord.lng)
        newPlace.registerX("\(coord.lat)")
        newPlace.registerY("\(coord.lng)")
    }


}
extension MapPlaceViewController: NMFMapViewCameraDelegate {

//    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
//
//    }
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        print("an is true")
        update()
    }
}
