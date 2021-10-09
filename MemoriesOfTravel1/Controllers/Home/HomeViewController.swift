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
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(true)
        // 우선 임시! 처음에 불러와지지 않아서 ㅠㅠ 
        if myInformation.getUserName() != "" {
            nameLable.text = myInformation.getUserName()+"님 !"
        }
    }


    
}
