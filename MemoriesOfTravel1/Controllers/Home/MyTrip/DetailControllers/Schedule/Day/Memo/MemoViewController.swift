//
//  MemoViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/16.
//

import UIKit
import Firebase

class MemoViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.shared
    let userManager = UserInfomation.shared
    let tripManager = TripInformation.shared
    let placeManager = PlaceInformation.shared
    
    var newMemo = [String]()
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func registerToDay(_ sender: UIButton){
        self.newMemo.append(self.content.text)
        self.placeManager.setMemoList(self.newMemo)
        firebaseManager.saveMemo(uid: userManager.getUid(), tripName: (tripManager.getTripInfo()?.getTripName())!, tripDate: placeManager.getTripDate()!, content: self.placeManager.getMemoList())
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        content.layer.cornerRadius = 20
        addButton.layer.cornerRadius = 20
        firebaseManager.loadMemo(uid: userManager.getUid(), tripName: (tripManager.getTripInfo()?.getTripName())!, tripDate: placeManager.getTripDate()!){ response in
            guard let response = response else {
                print("Memo 불러오기 실패")
                return
            }
            self.newMemo = response
            
        }
        
    }

}
