//
//  AddCalculateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

var selectDateStr: String = ""
var selectPayment: String = ""
var addCost: String = ""
var addContent: String = ""
var addWho: String = ""

class AddCalculateViewController: UIViewController {
    
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var whoTextField: UITextField!
    var registerCost = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        selectDateStr = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateButton.setTitle(selectDateStr, for: .normal)
    }
    
    @IBAction func selectMoney(_ sender: UIButton){
        moneyButton.layer.cornerRadius = 20
        moneyButton.backgroundColor = #colorLiteral(red: 0.8381986022, green: 1, blue: 0.9245430827, alpha: 1)
        cardButton.backgroundColor = .none
        selectPayment = "현금"
        
    }
    @IBAction func selectCard(_ sender: UIButton){
        cardButton.layer.cornerRadius = 20
        moneyButton.backgroundColor = .none
        cardButton.backgroundColor = #colorLiteral(red: 0.8381986022, green: 1, blue: 0.9245430827, alpha: 1)
        selectPayment = "카드"
    }
    
    @IBAction func addButton(_ sender: UIButton){
        addCost = costTextField.text ?? "0"
        addContent = contentTextField.text ?? ""
        addWho = whoTextField.text ?? ""

        registerCost["지불날짜"] = selectDateStr
        registerCost["지불방식"] = selectPayment
        registerCost["비용"] = addCost
        registerCost["내용"] = addContent
        registerCost["결제한사람"] = addWho
        costList.append(registerCost)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
