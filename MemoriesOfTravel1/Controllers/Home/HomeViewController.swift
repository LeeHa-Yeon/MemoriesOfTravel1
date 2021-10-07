//
//  HomeViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLable.text = "하연님 !"

    }
    
}
