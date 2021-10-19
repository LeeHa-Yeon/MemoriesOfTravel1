//
//  MyProfileViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit
import Firebase
import FirebaseAuth

class MyProfileViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tripCntLabel.text = myInformation.getTripCnt() + "회"
    }
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet{
            nameLabel.text = myInformation.getName()
        }
    }
    @IBOutlet weak var idLabel: UILabel! {
        didSet{
            idLabel.text = myInformation.getId()
        }
    }
    @IBOutlet weak var tripCntLabel: UILabel! {
        didSet {
            tripCntLabel.text = myInformation.getTripCnt() + "회"
        }
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBAction func logoutButton(_ sender: UIButton!){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
