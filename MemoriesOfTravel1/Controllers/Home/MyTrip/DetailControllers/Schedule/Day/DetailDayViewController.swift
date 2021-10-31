//
//  DetailDayViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/29.
//

import UIKit

class DetailDayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let placeInfo: PlaceInformation = PlaceInformation.shared
    var scheduleList = [String]()
    var memoList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        scheduleList = placeInfo.getScheduleList()
        memoList = placeInfo.getMemoList()
        title = placeInfo.getTripDate()
    }
    
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        let contentCellNib = UINib(nibName: "ContentCell", bundle: nil)
        self.tableView.register(contentCellNib, forCellReuseIdentifier: "ContentCell")
    }
    
    
}

extension DetailDayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleList.count + memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentCell else {
            return UITableViewCell()
        }
        if indexPath.row < scheduleList.count {
            if scheduleList[indexPath.row] == "일정을 추가해주세요" {
                cell.placeName.text = "일정 순서"
                cell.category.image = .none
                cell.backgroundColor = #colorLiteral(red: 0.8984330297, green: 0.8027767539, blue: 0.9092169404, alpha: 1)
            }else{
                cell.placeName.text = scheduleList[indexPath.row]
                for i in placeInfo.scheduleInfoList {
                    if i.key == scheduleList[indexPath.row] {
                        let categoryName = i.value["category"]
                        cell.category.image = UIImage(named: "\(categoryName ?? "기타")카테고리")
                    }
                }
            }
        }else{
            cell.placeName.text = memoList[indexPath.row - scheduleList.count]
            cell.category.image = UIImage(named: "메모카테고리")
        }
        return cell
    }
    
}
