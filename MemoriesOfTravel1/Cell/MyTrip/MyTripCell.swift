//
//  MyTripCell.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit

class MyTripCell: UICollectionViewCell {
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripDdayLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var tripImage: UIButton!
    
    @IBAction func moveDetailView(_ sender: UIButton){
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
