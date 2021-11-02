//
//  DayViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import Firebase

protocol moveVCProtocol {
    func moveToSelect()
    func moveToMemo()
    func moveToDetailDay()
}

class DayViewController: UIViewController {
    
    let myInformation: UserInfomation = UserInfomation.shared
    let selectTripInfo: TripInformation = TripInformation.shared
    var tripPeriod: Int = 0
    var tripFirstDay = Date()
    
    @IBOutlet weak var customTableView: UITableView!
    var selectIndex: IndexPath = [100,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        tripPeriod = Int(selectTripInfo.getTripInfo()!.getTripPeriod()) ?? 0
        tripFirstDay = formatter2.date(from: selectTripInfo.getTripInfo()!.getTripFirstDay())!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //  customTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupTableView(){
        customTableView.delegate = self
        customTableView.dataSource = self
        customTableView.separatorStyle = .none
        let dayCellNib = UINib(nibName: "DayCell", bundle: nil)
        self.customTableView.register(dayCellNib, forCellReuseIdentifier: "DayCell")
        customTableView.layer.cornerRadius = 20
    }
    
    var isExpending = ExpendingTableCellContent()
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월_dd일"
        return formatter
    }()
    
    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter2.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter2
    }()

}

extension DayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripPeriod
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in 0..<tripPeriod {
            if section == i {
                return "Day \(i+1)"
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? DayCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.dateLabel.text = formatter.string(from: tripFirstDay+TimeInterval(86400*(indexPath.section)))
        cell.settingData(isClicked: isExpending)
        return cell
    }
    
    // 셀을 선택했을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath
        guard let cell = customTableView.cellForRow(at: indexPath) as? DayCell else {return}
        guard let index = customTableView.indexPath(for: cell) else { return }
        if selectIndex == index {
            let content = isExpending
            content.expanded = !content.expanded
            customTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = customTableView.cellForRow(at: indexPath) as? DayCell else { return 45 }
        guard let index = customTableView.indexPath(for: cell) else { return 45 }
        if selectIndex == index {
            if isExpending.expanded {
                return 250
            }else {
                return 45
            }
        }
        return 45
    }
    
}

class ExpendingTableCellContent {
    var expanded: Bool
    init(){
        self.expanded = false
    }
}


extension DayViewController: moveVCProtocol {
    func moveToDetailDay() {
        guard let DateilDayVC = self.storyboard?.instantiateViewController(identifier: "DetailDaySB") as? DetailDayViewController else {
            return
        }
        navigationController?.pushViewController(DateilDayVC, animated: true)
    }
    

    func moveToMemo() {
        guard let MemoVC = self.storyboard?.instantiateViewController(identifier: "MemoSB") as? MemoViewController else {
            return
        }
        MemoVC.modalPresentationStyle = .formSheet
        self.present(MemoVC, animated: true, completion: nil)
    }
    
    func moveToSelect() {
        guard let SelectVC = self.storyboard?.instantiateViewController(identifier: "SelectSB") as? SelectViewController else {
            return
        }
        navigationController?.pushViewController(SelectVC, animated: true)
    }
    
}
