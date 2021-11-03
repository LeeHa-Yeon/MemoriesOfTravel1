//
//  DetailTripViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/11.
//

import UIKit

class DetailTripViewController: UIViewController {
    
    let selectTripInformation: TripInformation = TripInformation.shared
    let firebaseManager = FirebaseManager.shared
    let myInfo = UserInfomation.shared
    let checkManager = CheckListManager.shared
    let calculateManager = CalculateManager.shared
    let albumManger = AlbumManager.shared
    let weatherInfo = WeatherManager.shared
    let companionInfo = CompanionManager.shared
    
    var weather: Weather?
    var main: Main?
    var name: String?
    var weatherIconName: String = ""
    
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var oneView: UIView!
    @IBOutlet weak var twoView: UIView!
    @IBOutlet weak var threeView: UIView!
    @IBOutlet weak var fourView: UIView!
    
    @IBAction func backButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func moveScheduleView(_ sender: UIButton){
    }
    
    @IBAction func moveCalculateView(_ sender: UIButton){
//        guard let CalculateVC = self.storyboard?.instantiateViewController(identifier: "CalculateSB") as? CalculateViewController else {
//            return
//        }
        
        firebaseManager.loadCalculate(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.calculateManager.setCalculateList(response!)
        }
        firebaseManager.loadExpectedCost(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.calculateManager.setExpectedCost(response!)
//            CalculateVC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(CalculateVC, animated: true)
            
//            self.present(CalculateVC,animated: true)
        }
    }
    
    @IBAction func moveCheckListView(_ sender: UIButton){
//        guard let CheckVC = self.storyboard?.instantiateViewController(identifier: "CheckSB") as? CheckListViewController else {
//            return
//        }
        firebaseManager.loadCheckList(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.checkManager.setCheckList(response!)
        }
        firebaseManager.loadUnCheckList(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.checkManager.setUnCheckList(response!)
//            CheckVC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(CheckVC, animated: true)
        }
       
    }
    @IBAction func moveAlbumView(_ sender: UIButton){
        firebaseManager.loadAlbum(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.albumManger.setAlbumCnt(response!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
//        self.navigationItem.title = selectTripInformation.getTripInfo()!.getTripName()+"여행"
        tripDateLabel.text = "2021. "+selectTripInformation.getTripInfo()!.getTripDate()
        tripNameLabel.text = "안녕, \(selectTripInformation.getTripInfo()!.getTripName())여행"
        oneView.layer.cornerRadius = 30
        twoView.layer.cornerRadius = 30
        threeView.layer.cornerRadius = 30
        fourView.layer.cornerRadius = 30
        
        WeatherService().getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    
                    self.weatherInfo.setIconName(self.setWeatherUI())
                    self.weatherInfo.setDescription(self.weather!.description)
                    self.weatherInfo.setNowTemp(self.main!.temp)
                    self.weatherInfo.setTempMax(self.main!.temp_max)
                    self.weatherInfo.setTempMin(self.main!.temp_min)
                    self.weatherInfo.setHumidity(self.main!.humidity)
                }
            case .failure(_ ):
                print("DetailTrip - WeatherService Error")
            }
        }
        
    }
    //MARK: - 만든 아이콘 대입하는 부분
    private func setWeatherUI() -> String {
        var weatherIcon:String = "02n"
        weatherIcon = self.weather!.icon
        if weatherIcon == "01d"{
            weatherIconName = "01d"
        }
        else if weatherIcon == "01n"{
            weatherIconName = "01n"
        }
        else if weatherIcon == "02d"{
            weatherIconName = "02d"
        }
        else if weatherIcon == "02n"{
            weatherIconName = "02n"
        }
        else if weatherIcon == "03d" || weatherIcon == "03n" {
            weatherIconName = "03"
        }
        else if weatherIcon == "04d" || weatherIcon == "04n" {
            weatherIconName = "04"
        }
        else if weatherIcon == "09d" || weatherIcon == "09n"{
            weatherIconName = "09"
        }
        else if weatherIcon == "10d"{
            weatherIconName = "10d"
        }
        else if weatherIcon == "10n"{
            weatherIconName = "10n"
        }
        else if weatherIcon == "11d" || weatherIcon == "11n"{
            weatherIconName = "11"
        }
        else if weatherIcon == "13d" || weatherIcon == "13n"{
            weatherIconName = "13"
        }
        else if weatherIcon == "50d" || weatherIcon == "50n"{
            weatherIconName = "50"
        }

        return weatherIconName

    }
    

}
