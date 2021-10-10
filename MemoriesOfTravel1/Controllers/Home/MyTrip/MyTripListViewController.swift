//
//  HomeViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/07.
//

import UIKit
import Firebase

protocol MyTripCellDelegate {
    func moveToScheduleVC()
}

class MyTripListViewController: UIViewController {
    
    @IBOutlet weak var tripListTableView: UITableView!
    var ref = Database.database().reference()
    var myTripDict = [String: [String:Any]]()
    let myInformation: UserInfomation = UserInfomation.shared
    let aTest : aManager = aManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadingDate{ response in
            self.myTripDict = response
            print("bb",self.myTripDict)
        }
        print("bb2",self.myTripDict)
        tripListTableView.reloadData()
    }
    
    private func setupTableView(){
        tripListTableView.delegate = self
        tripListTableView.dataSource = self
        
        let tripListCellNib = UINib(nibName: "TripListCell", bundle: nil)
        self.tripListTableView.register(tripListCellNib, forCellReuseIdentifier: "TripListCell")
    }
    
    
    
    func loadingDate(completion: @escaping (([String: [String:Any]])->(Void))){
        self.ref.child("user").child("\(myInformation.getPrimaryKey())").child("myTripList").observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value
            let dic = values as! [String: [String:Any]]
            completion(dic)
        })
    }

}

extension MyTripListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 1
        case 1 :
            return 1
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0 :
            return self.tripListTableView.frame.height / 2 - 40
        case 1:
            return self.tripListTableView.frame.height / 2 - 40
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            if let cell = tripListTableView.dequeueReusableCell(withIdentifier: "TripListCell") as? TripListCell {
                cell.delegate = self
                cell.myTripList = self.myTripDict
                cell.listSectionLabel.text = "  여행 전"
                return cell
            }
        case 1:
            if let cell = tripListTableView.dequeueReusableCell(withIdentifier: "TripListCell") as? TripListCell {
                
                cell.listSectionLabel.text = "  여행 후"
                return cell
            }
        default :
            return UITableViewCell()
        }
        return UITableViewCell()

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "나만의 여행 리스트"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
        myLabel.textAlignment = .center
        myLabel.font = UIFont(name: "나눔손글씨 반짝반짝 별", size: 35)
        myLabel.textColor = .white
        myLabel.backgroundColor = #colorLiteral(red: 0.1206660345, green: 0.5541087389, blue: 0.7092294693, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
}

extension MyTripListViewController: MyTripCellDelegate{
    func moveToScheduleVC() {
        
        guard let ScheduleVC = self.storyboard?.instantiateViewController(identifier: "ScheduleSB") as? ScheduleViewController else {
            return
        }
        navigationController?.pushViewController(ScheduleVC, animated: true)
        
        
    }
}
