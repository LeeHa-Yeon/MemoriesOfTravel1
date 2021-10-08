//
//  HomeViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

class HomeViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var nameLable: UILabel! {
        didSet{
            nameLable.text = myInformation.getUserName()+"님 !"
        }
    }

    
}
