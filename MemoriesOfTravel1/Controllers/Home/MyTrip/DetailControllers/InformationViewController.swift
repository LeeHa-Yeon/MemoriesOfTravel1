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
    let compaionManager = CompanionManager.shared
    let firebaseManager = FirebaseManager.shared
    let myInfo = UserInfomation.shared
    
    var companionNameList = [String]()
    
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
        
        let alert = UIAlertController(title: "추가", message: "동행자 이름을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                self.companionNameList.append(text)
                self.companionCntLabel.text = "\(self.companionNameList.count)" + "명"
                self.collectionView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func removeCompanion(_ sender: UIButton){
        
        let alert = UIAlertController(title: "삭제", message: "동행자 이름을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                
                guard let findIndex = self.companionNameList.firstIndex(of: text) else {
                    print("값이 없음")
                    return
                }
                self.companionNameList.remove(at: findIndex)
                self.companionCntLabel.text = "\(self.companionNameList.count)" + "명"
                self.collectionView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func closeButton(_ sender: UIButton){
        firebaseManager.saveCompanion(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, companionList: companionNameList)
        self.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.loadCompanion(uid: myInfo.getUid(), tripName: tripInfo.getTripInfo()!.getTripName()) { response in
            guard let response = response else {
                print("아직 동행자 없음")
                return
            }
            self.compaionManager.setCompanionList(response)
            self.companionNameList = response
            self.loadTripData()
            self.setupCollection()
        }
        loadWeatherData()
        
        tripInfoView.layer.cornerRadius = 30
        weatherInfoView.layer.cornerRadius = 30
        
    }
    
    func loadTripData(){
        tripNameLabel.text = tripInfo.getTripInfo()?.getTripName()
        tripRangeLabel.text = (tripInfo.getTripInfo()?.getTripPeriod())! + "일"
        companionCntLabel.text = "\(companionNameList.count)" + "명"
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
        return companionNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companionCell", for: indexPath) as? CompanionCell else {
            return UICollectionViewCell()
        }
        cell.companionName.text = companionNameList[indexPath.row]
        return cell
    }
    
    
}

class CompanionCell : UICollectionViewCell {
    @IBOutlet weak var companionImg: UIImageView!
    @IBOutlet weak var companionName: UILabel!
    
}
