//
//  HomeViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

class HomeViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    
    @IBOutlet weak var nameLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if myInformation.getUserName() != "" {
            nameLable.text = myInformation.getUserName()+"님 !"
        }
    }
}
