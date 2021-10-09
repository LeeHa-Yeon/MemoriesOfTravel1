//
//  RegisterTripViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class RegisterTripViewController: UIViewController {
    
    let registerTripInfo: TripInformation = TripInformation.shared
    
    @IBOutlet weak var tripName: UIButton!
    @IBOutlet weak var tripDate: UIButton!
    @IBAction func cancleButton(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func moveAddTrip(_ sender: UIButton){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tripName.layer.borderWidth = 1.5
        tripName.layer.borderColor = #colorLiteral(red: 0.4392628074, green: 0.4358027577, blue: 0.4419106245, alpha: 1)
        tripName.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        tripName.layer.cornerRadius = 10
        
        tripDate.layer.borderWidth = 1.5
        tripDate.layer.borderColor = #colorLiteral(red: 0.5670574307, green: 0.5625883341, blue: 0.5704758763, alpha: 1)
        tripDate.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        tripDate.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let loadingTripName = NSAttributedString(string: registerTripInfo.getTripName())
        let loadingTripDate = NSAttributedString(string: registerTripInfo.getTripDate())
        self.tripName.setAttributedTitle(loadingTripName, for: .normal)
        self.tripDate.setAttributedTitle(loadingTripDate, for: .normal)
    }

}
