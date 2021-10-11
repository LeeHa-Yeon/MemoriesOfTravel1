//
//  MapViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class MapViewController: UIViewController {
    
    let selectTripInfo: TripInformation = TripInformation.shared
    @IBOutlet weak var customTableView: UITableView!
    var selectIndex: IndexPath = [100,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView(){
        customTableView.delegate = self
        customTableView.dataSource = self
        customTableView.separatorStyle = .none
        let mapCellNib = UINib(nibName: "MapCell", bundle: nil)
        self.customTableView.register(mapCellNib, forCellReuseIdentifier: "MapCell")
        
    }
    
    var isExpending = ExpendingTableCellContent3()
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()

}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectTripInfo.getTripRange()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in 0..<selectTripInfo.getTripRange() {
            if section == i {
                return "Day \(i+1)"
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? MapCell else {
            return UITableViewCell()
        }
        cell.settingData(isClicked: isExpending)
        cell.dateLabel.text = formatter.string(from: selectTripInfo.getTripFirstDay()+TimeInterval(86400*(indexPath.section)))
        return cell
    }
    
    // 셀을 선택했을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath
        guard let cell = customTableView.cellForRow(at: indexPath) as? MapCell else {return}
        guard let index = customTableView.indexPath(for: cell) else { return }
        if selectIndex == index {
            let content = isExpending
            content.expanded = !content.expanded
            customTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = customTableView.cellForRow(at: indexPath) as? MapCell else { return 45 }
        guard let index = customTableView.indexPath(for: cell) else { return 45 }
        if selectIndex == index {
            if isExpending.expanded {
                return 450
            }else {
                return 45
            }
        }
        return 45
    }
}

class ExpendingTableCellContent3 {
    var expanded: Bool
    init(){
        self.expanded = false
    }
}
