//
//  ExplanationViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/02.
//

import UIKit

class ExplanationViewController: UIViewController {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancleButton: UIButton!
    @IBAction func confirmTap(_ sender: UIButton){
        guard let CalculateVC = self.storyboard?.instantiateViewController(identifier: "CalculateSB") as? CalculateViewController else {
            return
        }
        CalculateVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(CalculateVC, animated: true)
    }
    @IBAction func cancleTap(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 20
        cancleButton.layer.cornerRadius = 20
    }


}
