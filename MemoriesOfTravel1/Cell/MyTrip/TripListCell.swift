//
//  TripListCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class TripListCell: UITableViewCell {
    // prepareToReuse
    
    @IBOutlet weak var listSectionLabel: UILabel!
    @IBOutlet weak var myTripCollectionView: UICollectionView!
    let behavior = MSCollectionViewPeekingBehavior()
    var delegate: MyTripCellDelegate?
    var myTripList = [String]()
    var myTripInfo = [TripInfo]()
    
    let userInfo = UserInfomation.shared
    let firebaseManager = FirebaseManager.shared
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 테이블 관련된 것
    private func setupCollectionView(){
        myTripCollectionView.dataSource = self
        myTripCollectionView.delegate = self
        // 나의 셀 관련된 것
        let myTripCellNib = UINib(nibName: "MyTripCell", bundle: nil)
        self.myTripCollectionView.register(myTripCellNib, forCellWithReuseIdentifier: "MyTripCell")
        behavior.cellSpacing = 0
        behavior.cellPeekWidth = 0
        behavior.numberOfItemsToShow = 1
        myTripCollectionView.configureForPeekingBehavior(behavior: behavior)
        myTripCollectionView.layer.cornerRadius = 50
        myTripCollectionView.layer.borderColor = #colorLiteral(red: 0.5236939192, green: 0.6544969678, blue: 0.6698578596, alpha: 1)
        myTripCollectionView.layer.borderWidth = 3.0
        myTripCollectionView.isPagingEnabled = true
    }
    
    
    
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return formatter
    }()
    
}

extension TripListCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTripList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTripCell", for: indexPath) as? MyTripCell {
            cell.delegate = self.delegate
            let firstDate:Date = self.formatter.date(from: myTripInfo[indexPath.row].getTripFirstDay())!
            let dDay = Int(firstDate-Date())/(24*60*60)
            if dDay < 0 {
                cell.tripDdayLabel.text = "D+\(-dDay)"
            }else if dDay == 0{
                cell.tripDdayLabel.text = "D-day"
            }
            else{
                cell.tripDdayLabel.text = "D-\(dDay)"
            }

            let tripImageName = UIImage(named: myTripInfo[indexPath.row].getTripName())
            cell.tripImage.setImage(tripImageName, for: .normal)

            cell.tripNameLabel.text = myTripInfo[indexPath.row].getTripName()
            cell.tripDateLabel.text = myTripInfo[indexPath.row].getTripDate()
            
            return cell
            
        }
        return UICollectionViewCell()
    }
}
