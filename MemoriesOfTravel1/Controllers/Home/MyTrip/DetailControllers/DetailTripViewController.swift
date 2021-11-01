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
    
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBAction func moveScheduleView(_ sender: UIButton){
    }
    
    @IBAction func moveCalculateView(_ sender: UIButton){
        guard let CalculateVC = self.storyboard?.instantiateViewController(identifier: "CalculateSB") as? CalculateViewController else {
            return
        }
        
        firebaseManager.loadCalculate(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.calculateManager.setCalculateList(response!)
        }
        firebaseManager.loadExpectedCost(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.calculateManager.setExpectedCost(response!)
            CalculateVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(CalculateVC, animated: true)
            
        }
    }
    
    @IBAction func moveCheckListView(_ sender: UIButton){
        guard let CheckVC = self.storyboard?.instantiateViewController(identifier: "CheckSB") as? CheckListViewController else {
            return
        }
        firebaseManager.loadCheckList(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.checkManager.setCheckList(response!)
        }
        firebaseManager.loadUnCheckList(uid: myInfo.getUid(), tripName: selectTripInformation.getTripInfo()!.getTripName()) { response in
            self.checkManager.setUnCheckList(response!)
            CheckVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(CheckVC, animated: true)
        }
       
    }
    @IBAction func moveAlbumView(_ sender: UIButton){

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "나눔손글씨 반짝반짝 별", size: 40)!]
        self.navigationItem.title = selectTripInformation.getTripInfo()!.getTripName()+"여행"
        tripDateLabel.text = "2021. "+selectTripInformation.getTripInfo()!.getTripDate()
        
    }
    

}
