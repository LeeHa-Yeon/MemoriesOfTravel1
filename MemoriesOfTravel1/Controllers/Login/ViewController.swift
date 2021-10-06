//
//  ViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/09/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        if let viewController = storyboard.instantiateViewController(identifier: "OneViewController") as? OneViewController {
            addChild(viewController)
            firstView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

