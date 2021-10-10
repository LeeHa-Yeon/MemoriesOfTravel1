//
//  DayCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class DayCell: UITableViewCell {

    var placeArr = ["베니키아","랑데자뷰","대림창고"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var toggleLebel: UILabel!
    
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var addMemoButton: UIButton!
    @IBAction func addNewPlace(_ sender: UIButton){
        placeArr.append("d")
        tableView.reloadData()
    }
    @IBAction func addNewMemo(_ sender: UIButton){
        placeArr.append("e")
        tableView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        
        let contentCellNib = UINib(nibName: "ContentCell", bundle: nil)
        self.tableView.register(contentCellNib, forCellReuseIdentifier: "ContentCell")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func settingData(isClicked: ExpendingTableViewCellContent2) {
        if isClicked.expanded {
            self.toggleLebel.text = "▽"
            self.addMemoButton.isHidden = false
            self.addPlaceButton.isHidden = false
        } else {
            self.toggleLebel.text = "△"
            self.addMemoButton.isHidden = true
            self.addPlaceButton.isHidden = true
        }
    }
    
}


extension DayCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentCell {
            cell.placeName.text = placeArr[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
}
