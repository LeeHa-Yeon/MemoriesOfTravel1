//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

class ViewController: UITabBarController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
    }
    
}
