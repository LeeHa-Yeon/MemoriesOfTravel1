//
//  DayCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import Firebase

class DayCell: UITableViewCell {
    
    var delegate: moveVCProtocol?
    let placeInfo: PlaceInformation = PlaceInformation.shared
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var toggleLebel: UILabel!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var addMemoButton: UIButton!
    @IBAction func showSchedule(_ sender: UIButton){
        print("일정 보여주는 화면 구현하기")
    }
    
    @IBAction func addNewPlace(_ sender: UIButton){
        placeInfo.setTripDate(dateLabel.text!)
        delegate?.moveToSelect()
    }
    @IBAction func addNewMemo(_ sender: UIButton){
        print("안녕!나는 메모!")
        placeInfo.setTripDate(dateLabel.text!)
        delegate?.moveToMemo()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func settingData(isClicked: ExpendingTableCellContent) {
        if isClicked.expanded {
            self.toggleLebel.text = "▲"
            self.addMemoButton.isHidden = false
            self.addPlaceButton.isHidden = false
        } else {
            self.toggleLebel.text = "▽"
            self.addMemoButton.isHidden = true
            self.addPlaceButton.isHidden = true
        }
    }
}
