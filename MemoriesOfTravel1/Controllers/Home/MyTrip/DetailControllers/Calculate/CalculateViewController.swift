//
//  CalculateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/11/01.
//

import UIKit

var costList = [[String:Any]]()

class CalculateViewController: UIViewController {
    
    let tripInfo: TripInformation = TripInformation.shared
    let firebaseManager = FirebaseManager.shared
    let myInfo = UserInfomation.shared
    let calculateManager = CalculateManager.shared
    
    @IBOutlet weak var expectedCost: UILabel!
    @IBOutlet weak var leftCost: UILabel!
    @IBOutlet weak var usedCost: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var expected: Int = 0
    var left: Int = 0
    var used: Int = 0
    
    @IBAction func confirm(_ sender: UIButton){
        firebaseManager.saveExpectedCost(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, content: "\(expected)")
        firebaseManager.saveCalculate(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, content: costList)
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addExpectedCost(_ sender: Any) {
        let alert = UIAlertController(title: "등록", message: "예상 비용을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Expected Cost input"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                self.expectedCost.text = text
                self.expected = Int(text) ?? 0
                self.left = self.expected - self.used
                self.leftCost.text = "\(self.left)"
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        expected = Int(calculateManager.getExpectedCost()) ?? 0
        expectedCost.text = calculateManager.getExpectedCost()
        costList = calculateManager.getCalculateList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.calculateCost()
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func calculateCost(){
        used = 0
        if costList.count != 0 {
            for item in costList {
                used += Int(item["비용"] as! String) ?? 0
            }
        }
        left = expected - used
        leftCost.text = "\(left)"
        usedCost.text = "\(used)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let detailView = segue.destination as! DetailCalculateViewController
            detailView.receiveItem(costList[((indexPath as NSIndexPath?)?.row)!])
        }
    }
    
    
}

extension CalculateViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "calculateCell", for: indexPath) as? CalculateCell else {
            return UITableViewCell()
        }
        cell.costLabel.text = costList[indexPath.row]["비용"] as? String
        cell.content.text = costList[indexPath.row]["내용"] as? String
        return cell
    }
    
    
    
}


class CalculateCell: UITableViewCell {
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var content: UILabel!
    
}

