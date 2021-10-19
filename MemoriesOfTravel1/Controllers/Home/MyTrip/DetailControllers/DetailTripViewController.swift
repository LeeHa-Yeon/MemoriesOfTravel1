//
//  DetailTripViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/11.
//

import UIKit

class DetailTripViewController: UIViewController {
    
    let selectTripInformation: TripInformation = TripInformation.shared
    
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBAction func moveScheduleView(_ sender: UIButton){
    }
    @IBAction func moveCalculateView(_ sender: UIButton){

    }
    @IBAction func moveCheckListView(_ sender: UIButton){

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
