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
    var myTripList = [String: [String:Any]]()
    
    
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
}

extension TripListCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myTripList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTripCell", for: indexPath) as? MyTripCell {
            cell.delegate = self.delegate
            var tripNameArr = [String]()
            var tripDateArr = [String]()
            var tripDdayArr = [String]()
            var tripImageArr = [String]()
            for test in myTripList.values{
                var toStringDday:Int = 0
                toStringDday = test["디데이"] as! Int
                tripNameArr.append((test["여행지"] as? String)!)
                tripDateArr.append((test["날짜"] as? String)!)
                tripDdayArr.append("D-"+String(toStringDday))
                tripImageArr.append(test["여행사진"] as! String)
            }
            let tripImageName = UIImage(named: tripImageArr[indexPath.row])
            cell.tripNameLabel.text = tripNameArr[indexPath.row]
            cell.tripDateLabel.text = tripDateArr[indexPath.row]
            cell.tripDdayLabel.text = tripDdayArr[indexPath.row]
            cell.tripImage.setImage(tripImageName, for: .normal)
            return cell
        }
        return UICollectionViewCell()
    }
}
