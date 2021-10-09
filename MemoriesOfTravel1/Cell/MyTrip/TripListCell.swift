//
//  TripListCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class TripListCell: UITableViewCell {
    @IBOutlet weak var listSectionLabel: UILabel!
    @IBOutlet weak var myTripCollectionView: UICollectionView!
    let behavior = MSCollectionViewPeekingBehavior()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCollectionView(){
        myTripCollectionView.dataSource = self
        myTripCollectionView.delegate = self
        
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
        return 4
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTripCell", for: indexPath) as? MyTripCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
}
