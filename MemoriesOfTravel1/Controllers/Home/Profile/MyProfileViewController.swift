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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tripCntLabel: UILabel!
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
