//
//  AddSuppliesViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

class AddSuppliesViewController: UIViewController {
    
    @IBOutlet weak var suppliesTextField: UITextField!
    @IBAction func addButton(_ sender: UIButton){
        checkItemes.append(suppliesTextField.text!)
        suppliesTextField.text = ""
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
