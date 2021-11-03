//
//  DetailDayViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/29.
//

import UIKit

class DetailDayViewController: UIViewController {
    
    let myInfo = UserInfomation.shared
    let tripInfo = TripInformation.shared
    let firebaseManager = FirebaseManager.shared
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
        
    }()
    @objc private func buttonPressed(_ sender: Any) { if let button = sender as? UIBarButtonItem {
        switch button.tag {
        case 1:
            if self.tableView.isEditing {
                self.tableView.setEditing(false, animated: true)
            } else {
                self.tableView.setEditing(true, animated: true)
            }
        default:
            print("error")
        }
    }
    }
    @IBAction func saveTapped(_ sender: UIButton) {
        firebaseManager.savePlace(uid: myInfo.getUid(), tripName: (tripInfo.getTripInfo()?.getTripName())!, tripDate: placeInfo.getTripDate()!, schedule: scheduleList)
    }
    
    
    let placeInfo: PlaceInformation = PlaceInformation.shared
    var scheduleList = [String]()
    var memoList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        scheduleList = placeInfo.getScheduleList()
        memoList = placeInfo.getMemoList()
        title = placeInfo.getTripDate()
        self.navigationItem.rightBarButtonItem = leftButton
        saveButton.layer.cornerRadius = 15
        
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
                cell.backgroundColor = #colorLiteral(red: 0.495657444, green: 0.7202214599, blue: 0.9071255922, alpha: 1)
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
    //---------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popItmes = scheduleList.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
    
    // 목록 삭제 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scheduleList.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
        
    }
    
    // 목록 순서 바꾸기
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = scheduleList[(fromIndexPath as NSIndexPath).row]
        //        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        scheduleList.remove(at: (fromIndexPath as NSIndexPath).row)
        //        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        scheduleList.insert(itemToMove, at: (to as NSIndexPath).row)
        //        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
        
    }
    
    
    
}
