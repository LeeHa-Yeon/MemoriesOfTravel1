//
//  DayViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class DayViewController: UIViewController {
    
    @IBOutlet weak var customTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    var answerFilterDatasource = ExpendingTableViewCellContent2()
    
    private func setupTableView(){
        customTableView.delegate = self
        customTableView.dataSource = self
        customTableView.separatorStyle = .none
        customTableView.rowHeight = UITableView.automaticDimension
        let dayCellNib = UINib(nibName: "DayCell", bundle: nil)
        self.customTableView.register(dayCellNib, forCellReuseIdentifier: "DayCell")
        
    }
    
}

extension DayViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 셀을 선택했을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = customTableView.cellForRow(at: indexPath) as? DayCell else {return}
        guard let index = customTableView.indexPath(for: cell) else { return }
        if index.section == indexPath.section {
            print(indexPath.row)
            let content = answerFilterDatasource
            content.expanded = !content.expanded
            customTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if answerFilterDatasource.expanded {
            return 300
        }else {
            return 40        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? DayCell else {
            return UITableViewCell()
        }
        cell.settingData(isClicked: answerFilterDatasource)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day 1"
    }
}

class ExpendingTableViewCellContent2 {
    var expanded: Bool
    init(){
        self.expanded = false
    }
}

