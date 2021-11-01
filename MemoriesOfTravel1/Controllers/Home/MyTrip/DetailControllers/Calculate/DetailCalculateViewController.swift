//
//  DetailCalculateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

class DetailCalculateViewController: UIViewController {
    
    @IBOutlet weak var personLable: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBAction func okbutton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    var receiveDict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personLable.text = receiveDict["결제한사람"] as? String
        methodLabel.text = receiveDict["지불방식"] as? String
        dateLabel.text = receiveDict["지불날짜"] as? String
        contentLabel.text = receiveDict["내용"] as? String
        costLabel.text = receiveDict["비용"] as? String
        
    }
    
    // Main View에서 변수를 받아오기 위한 함수
    func receiveItem(_ item: [String:Any]){
        receiveDict = item
        print("특정--->",receiveDict)
        
    }
    
    
}
