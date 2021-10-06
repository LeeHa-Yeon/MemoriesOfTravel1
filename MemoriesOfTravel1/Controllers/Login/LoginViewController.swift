//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let MyTripVC = UIStoryboard(name:"Main",bundle: nil).instantiateViewController(identifier: "MyTripListSB") as? MyTripListViewController {
            view.addSubview(MyTripVC.view)
            MyTripVC.didMove(toParent: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

