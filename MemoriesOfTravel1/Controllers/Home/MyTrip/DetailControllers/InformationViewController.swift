//
//  InformationViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/03.
//

import UIKit

class InformationViewController: UIViewController {
    
    let weatherManager = WeatherManager.shared
    let tripInfo = TripInformation.shared
    
    @IBOutlet weak var tripInfoView: UIView!
    @IBOutlet weak var weatherInfoView: UIView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripRangeLabel: UILabel!
    @IBOutlet weak var companionCntLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func plusCompanion(_ sender: UIButton){
        
    }
    @IBAction func closeButton(_ sender: UIButton){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTripData()
        loadWeatherData()
        setupCollection()
        
        tripInfoView.layer.cornerRadius = 30
        weatherInfoView.layer.cornerRadius = 30
    }
    
    func loadTripData(){
        tripNameLabel.text = tripInfo.getTripInfo()?.getTripName()
        tripRangeLabel.text = (tripInfo.getTripInfo()?.getTripPeriod())! + "일"
        companionCntLabel.text = "3" + "명"
    }
    
    func loadWeatherData(){
        currentTempLabel.text = String(format: "%.1f", weatherManager.getNowTemp()) + "ºC"
        maxTempLabel.text = String(format: "%.1f", weatherManager.getTempMax()) + "ºC"
        minTempLabel.text = String(format: "%.1f", weatherManager.getTempMin()) + "ºC"
        humidityLabel.text = String(weatherManager.getHumidity()) + "%"
        weatherNameLabel.text = weatherManager.getDescription()
        weatherIcon.image = UIImage(named: weatherManager.getIconName())
    }
    
    func setupCollection(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }


}

extension InformationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companionCell", for: indexPath) as? CompanionCell else {
            return UICollectionViewCell()
        }
//        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    
}

class CompanionCell : UICollectionViewCell {
    @IBOutlet weak var companionImg: UIImageView!
    @IBOutlet weak var companionName: UILabel!
    
}
